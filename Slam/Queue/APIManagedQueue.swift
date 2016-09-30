import Foundation

open class APIManagedQueue: QueueManager {

    open var api: SlamAPI
    open var queueView: QueueView

    public init(queueView: QueueView) {
        self.api = SlamAPI(httpClient: AsynchronousHTTPClient())
        self.queueView = queueView
    }

    open func loadQueue(_ onSuccess: @escaping () -> Void) {
        api.getQueue({(matches: [Match]) in
            self.queueView.showMatches(matches)
            onSuccess()
        })
    }

    open func removeMatch(_ matchID: String) {
        api.removeMatchFromQueue(matchID, onSuccess: {
            self.queueView.removedMatch()
        })
    }
}
