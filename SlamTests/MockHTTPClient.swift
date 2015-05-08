import Foundation
import Slam

class MockHTTPClient: HTTPClient {

    var wasRequestMade: Bool
    var lastRequest: NSURLRequest?
    var response: String
    var lastRequestBody: String?

    init() {
        self.wasRequestMade = false
        self.response = ""
    }

    func makeRequest(request: NSURLRequest, onSuccess: (NSData) -> Void) {
        self.wasRequestMade = true
        self.lastRequest = request
        if let body = request.HTTPBody {
            let string = NSString(data: body, encoding: NSUTF8StringEncoding) as! String
            self.lastRequestBody = string
        }
        let data: NSData = response.dataUsingEncoding(NSUTF8StringEncoding)!
        onSuccess(data)
    }

    func setResponse(response: String) {
        self.response = response
    }
}
