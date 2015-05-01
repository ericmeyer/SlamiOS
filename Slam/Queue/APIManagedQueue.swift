import Foundation

public class APIManagedQueue: QueueManager {
    public let queueView: QueueView
    public var api: SlamAPI

    public init(queueView: QueueView) {
        self.api = SlamAPI(httpClient: AsynchronousHTTPClient())
        self.queueView = queueView
    }

    public func loadQueue() {
        api.getQueue({(matches: [Match]) in
            self.queueView.showMatches(matches)
        })
    }

    public func reloadQueue(callback: () -> Void) {
        api.getQueue({(matches: [Match]) in
            self.queueView.showMatches(matches)
            callback()
        })
    }
}