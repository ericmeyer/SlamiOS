import Foundation

public class APIManagedQueue: QueueManager {
    public var api: SlamAPI
    public var queueView: QueueView

    public init(queueView: QueueView) {
        self.api = SlamAPI(httpClient: AsynchronousHTTPClient())
        self.queueView = queueView
    }

    public func loadQueue(onSuccess: () -> Void) {
        api.getQueue({(matches: [Match]) in
            self.queueView.showMatches(matches)
            onSuccess()
        })
    }

    public func removeMatch(matchID: String) {
        api.removeMatchFromQueue(matchID, onSuccess: { () -> Void in self.queueView.removedMatch()})
    }

    public func setQueueView(queueView: QueueView) {
        self.queueView = queueView
    }
}