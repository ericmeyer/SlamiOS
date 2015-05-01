import Slam
import UIKit

class MockQueueManager: QueueManager {
    var loadQueueCalled = false
    var reloadQueueCalled = false
    var queueView: QueueView

    init() {
        queueView = QueueView(display: UITableView())
    }

    func loadQueue() {
        loadQueueCalled = true
    }

    func reloadQueue(callback: () -> Void) {
        reloadQueueCalled = true
    }
}