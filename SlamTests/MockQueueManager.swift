import Slam
import UIKit

public class MockQueueManager: QueueManager {
    var loadQueueCalled = false
    var reloadQueueCalled = false
    var removeMatchWasCalled = false
    public var queueView: QueueView

    init() {
        queueView = QueueView(display: UITableView())
    }

    public func loadQueue(callback: () -> Void) {
        reloadQueueCalled = true
    }

    public func removeMatch(matchId: String) {
        removeMatchWasCalled = true
    }

    public func setQueueView(queueView: QueueView) {
        self.queueView = queueView
    }
}