import Foundation

open class SlamAPI {
    open let getCurrentQueueURL = "http://slamapi.herokuapp.com/matches"
    open let addMatchURL = "http://slamapi.herokuapp.com/matches"
    open let removeMatchFromQueueURL = "http://slamapi.herokuapp.com/matches"
    open let loginURL = "http://slamapi.herokuapp.com/login"
    let httpClient: HTTPClient

    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    open func attemptLogin(email: String, password: String, onSuccess: @escaping (_ session: Session) -> Void) {
        let request = NSMutableURLRequest(
            url: URL(string: loginURL)!
        )
        request.httpMethod = "POST"
        let credentials = [
            "email": email,
            "password": password
        ]
        let postString = PostBody(params: credentials).asString()
        request.httpBody = (postString as NSString).data(using: String.Encoding.utf8.rawValue)

        httpClient.makeRequest(request as URLRequest, onSuccess: {(data: Data) in
            let sessionData: NSDictionary = self.deserializeJSON(data) as! NSDictionary
            let session = Session()
            session.token = sessionData["token"] as! String?
            if let isAuthenticated = sessionData["success"] as? Bool {
                session.isAuthenticated = isAuthenticated
            }
            onSuccess(session)
        })
    }

    open func addMatch(_ playerOne: String, playerTwo: String, onSuccess: @escaping () -> Void) {
        let request = NSMutableURLRequest(
            url: URL(string: addMatchURL)!
        )

        request.httpMethod = "POST"
        let players = [
            "playerOne": playerOne,
            "playerTwo": playerTwo
        ]
        let postString = PostBody(params: players).asString()
        request.httpBody = (postString as NSString).data(using: String.Encoding.utf8.rawValue)

        httpClient.makeRequest(request as URLRequest, onSuccess: {(data: Data) in
            onSuccess()
        })
    }

    open func getQueue(_ callback: @escaping ([Match]) -> Void) {
        let request = NSMutableURLRequest(
            url: URL(string: getCurrentQueueURL)!
        )
        httpClient.makeRequest(request as URLRequest, onSuccess: {(data: Data) in
            let matchDataList: [NSDictionary] = self.deserializeJSON(data) as! [NSDictionary]
            callback(matchDataList.map({matchData in
                Match(matchData: matchData as! [String : String])
            }))
        })
    }

    open func removeMatchFromQueue(_ id: String, onSuccess: @escaping () -> Void) {
        let request = NSMutableURLRequest(
            url: URL(string: "\(removeMatchFromQueueURL)?id=\(id)")!
        )

        request.httpMethod = "DELETE"
        httpClient.makeRequest(request as URLRequest, onSuccess: {(data: Data) in
            onSuccess()
        })

    }

    fileprivate func deserializeJSON(_ data: Data) -> AnyObject? {
        return try! JSONSerialization.jsonObject(
            with: data,
            options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject?
    }
}
