import Slam
import UIKit

class MockQueueManager: QueueManager {
    var loadQueueCalled = false
    var reloadQueueCalled = false
    var removeMatchWasCalled = false
    var queueView: QueueView

    init() {
        queueView = QueueView(display: UITableView())
    }

    func loadQueue(callback: () -> Void) {
        reloadQueueCalled = true
    }

    func removeMatch(matchId: String) {
        removeMatchWasCalled = true
    }
}