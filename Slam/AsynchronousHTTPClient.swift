import Foundation

public class AsynchronousHTTPClient: HTTPClient {
    public init() {}

    public func makeRequest(request: NSURLRequest, onSuccess: (NSData) -> Void) {
        NSURLConnection.sendAsynchronousRequest(
            request,
            queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response, data, error) in
                onSuccess(data)
            }
        )
    }
}
