import Foundation

public class SlamAPI {
    public let getCurrentQueueURL = "http://slamapi.herokuapp.com/matches"
    let httpClient: HTTPClient

    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    public func getQueue(callback: ([Match]) -> Void) {
        var request = NSMutableURLRequest(
            URL: NSURL(string: getCurrentQueueURL)!
        )
        httpClient.makeRequest(request, {(data: NSData) in
            var matchDataList: [NSDictionary] = self.deserializeJSON(data) as [NSDictionary]
            callback(matchDataList.map({matchData in
                Match(matchData: matchData as [String : String])
            }))
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
