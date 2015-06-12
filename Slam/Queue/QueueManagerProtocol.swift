public protocol QueueManager {
    var queueView: QueueView { get set }

    func loadQueue(onSuccess: () -> Void)

    func removeMatch(matchId: String)

    func setQueueView(queueView: QueueView)
}