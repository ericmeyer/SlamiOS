public protocol QueueManagerProtocol {
    func loadQueue()
    func reloadQueue(callback: () -> Void)
    var queueView: QueueView { get }
}