import Foundation

public class AsynchronousHTTPClient: HTTPClient {
    public init() {}

    public func makeRequest(_ request: URLRequest, onSuccess: @escaping (Data) -> Void) {
        NSURLConnection.sendAsynchronousRequest(
            request,
            queue: OperationQueue.main,
            completionHandler: {(response, data, error) in
                onSuccess(data!)
            }
        )
    }
}
