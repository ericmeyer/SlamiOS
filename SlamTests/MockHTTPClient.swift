import Foundation
import Slam

class MockHTTPClient: HTTPClient {

    var wasRequestMade: Bool
    var lastRequest: NSURLRequest?
    var response: String

    init() {
        self.wasRequestMade = false
        self.response = ""
    }

    func makeRequest(request: NSURLRequest, onSuccess: (NSData) -> Void) {
        self.wasRequestMade = true
        self.lastRequest = request
        let data: NSData = response.dataUsingEncoding(NSUTF8StringEncoding)!
        onSuccess(data)
    }

    func setResponse(response: String) {
        self.response = response
    }
}
