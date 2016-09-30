import Foundation

public protocol HTTPClient {
    func makeRequest(_ request: URLRequest, onSuccess: @escaping (Data) -> Void)
}
