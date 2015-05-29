import Foundation

public class SlamAPI {
    public let getCurrentQueueURL = "http://slamapi.herokuapp.com/matches"
    public let addMatchURL = "http://slamapi.herokuapp.com/matches"
    public let removeMatchFromQueueURL = "http://slamapi.herokuapp.com/matches"
    let httpClient: HTTPClient

    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    public func addMatch(playerOne: String, playerTwo: String, onSuccess: () -> Void) {
        var request = NSMutableURLRequest(
            URL: NSURL(string: addMatchURL)!
        )

        request.HTTPMethod = "POST"
        var players = [
            "playerOne": playerOne,
            "playerTwo": playerTwo
        ]
        var postString = PostBody(params: players).asString()
        request.HTTPBody = (postString as NSString).dataUsingEncoding(NSUTF8StringEncoding)

        httpClient.makeRequest(request, onSuccess: {(data: NSData) in
            onSuccess()
        })
    }

    public func getQueue(callback: ([Match]) -> Void) {
        var request = NSMutableURLRequest(
            URL: NSURL(string: getCurrentQueueURL)!
        )
        httpClient.makeRequest(request, onSuccess: {(data: NSData) in
            var matchDataList: [NSDictionary] = self.deserializeJSON(data) as! [NSDictionary]
            callback(matchDataList.map({matchData in
                Match(matchData: matchData as! [String : String])
            }))
        })
    }

    public func removeMatchFromQueue(id: String, onSuccess: () -> Void) {
        var request = NSMutableURLRequest(
            URL: NSURL(string: "\(removeMatchFromQueueURL)?id=\(id)")!
        )

        request.HTTPMethod = "DELETE"
        httpClient.makeRequest(request, onSuccess: {(data: NSData) in
            onSuccess()
        })

    }

    private func deserializeJSON(data: NSData) -> AnyObject? {
        return NSJSONSerialization.JSONObjectWithData(
            data,
            options: NSJSONReadingOptions.MutableContainers,
            error: nil
        )
    }
}
