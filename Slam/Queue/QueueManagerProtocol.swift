public protocol QueueManager {
    var queueView: QueueView { get }

    func loadQueue()
    func reloadQueue(callback: () -> Void)
}