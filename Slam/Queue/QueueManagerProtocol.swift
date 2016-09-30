public protocol QueueManager {
    
    var queueView: QueueView { get set }
    func loadQueue(_ onSuccess: @escaping () -> Void)
    func removeMatch(_ matchId: String)

}
