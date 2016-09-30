import Foundation
import Slam

class MockHTTPClient: HTTPClient {

    var wasRequestMade: Bool
    var lastRequest: URLRequest?
    var response: String
    var lastRequestBody: String?

    init() {
        self.wasRequestMade = false
        self.response = ""
    }

    func makeRequest(_ request: URLRequest, onSuccess: @escaping (Data) -> Void) {
        self.wasRequestMade = true
        self.lastRequest = request
        if let body = request.httpBody {
            let string = NSString(data: body, encoding: String.Encoding.utf8.rawValue) as! String
            self.lastRequestBody = string
        }
        let data: Data = response.data(using: String.Encoding.utf8)!
        onSuccess(data)
    }

    func setResponse(_ response: String) {
        self.response = response
    }
}
