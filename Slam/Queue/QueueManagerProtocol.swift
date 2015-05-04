public protocol QueueManager {
    var queueView: QueueView { get }

    func loadQueue(onSuccess: () -> Void)
}