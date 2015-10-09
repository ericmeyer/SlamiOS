import Foundation

public class SlamAPI {
    public let getCurrentQueueURL = "http://slamapi.herokuapp.com/matches"
    public let addMatchURL = "http://slamapi.herokuapp.com/matches"
    public let removeMatchFromQueueURL = "http://slamapi.herokuapp.com/matches"
    public let loginURL = "http://slamapi.herokuapp.com/login"
    let httpClient: HTTPClient

    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    public func attemptLogin(email email: String, password: String, onSuccess: (session: Session) -> Void) {
        let request = NSMutableURLRequest(
            URL: NSURL(string: loginURL)!
        )
        request.HTTPMethod = "POST"
        let credentials = [
            "email": email,
            "password": password
        ]
        let postString = PostBody(params: credentials).asString()
        request.HTTPBody = (postString as NSString).dataUsingEncoding(NSUTF8StringEncoding)

        httpClient.makeRequest(request, onSuccess: {(data: NSData) in
            let sessionData: NSDictionary = self.deserializeJSON(data) as! NSDictionary
            let session = Session()
            session.token = sessionData["token"] as! String?
            if let isAuthenticated = sessionData["success"] as? Bool {
                session.isAuthenticated = isAuthenticated
            }
            onSuccess(session: session)
        })
    }

    public func addMatch(playerOne: String, playerTwo: String, onSuccess: () -> Void) {
        let request = NSMutableURLRequest(
            URL: NSURL(string: addMatchURL)!
        )

        request.HTTPMethod = "POST"
        let players = [
            "playerOne": playerOne,
            "playerTwo": playerTwo
        ]
        let postString = PostBody(params: players).asString()
        request.HTTPBody = (postString as NSString).dataUsingEncoding(NSUTF8StringEncoding)

        httpClient.makeRequest(request, onSuccess: {(data: NSData) in
            onSuccess()
        })
    }

    public func getQueue(callback: ([Match]) -> Void) {
        let request = NSMutableURLRequest(
            URL: NSURL(string: getCurrentQueueURL)!
        )
        httpClient.makeRequest(request, onSuccess: {(data: NSData) in
            let matchDataList: [NSDictionary] = self.deserializeJSON(data) as! [NSDictionary]
            callback(matchDataList.map({matchData in
                Match(matchData: matchData as! [String : String])
            }))
        })
    }

    public func removeMatchFromQueue(id: String, onSuccess: () -> Void) {
        let request = NSMutableURLRequest(
            URL: NSURL(string: "\(removeMatchFromQueueURL)?id=\(id)")!
        )

        request.HTTPMethod = "DELETE"
        httpClient.makeRequest(request, onSuccess: {(data: NSData) in
            onSuccess()
        })

    }

    private func deserializeJSON(data: NSData) -> AnyObject? {
        return try? NSJSONSerialization.JSONObjectWithData(
            data,
            options: NSJSONReadingOptions.MutableContainers)
    }
}
