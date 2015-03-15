import Foundation

public protocol HTTPClient {
    func makeRequest(request: NSURLRequest, onSuccess: (NSData) -> Void)
}
