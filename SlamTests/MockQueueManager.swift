import Slam
import UIKit

class MockQueueManager: QueueManagerProtocol {
    var loadQueueCalled = false
    var reloadQueueCalled = false
    var reloadQueueCalledWith: (() -> Void)?
    var queueView: QueueView

    init() {
        queueView = QueueView(display: UITableView())
    }

    func loadQueue() {
        loadQueueCalled = true
    }

    func reloadQueue(callback: () -> Void) {
        reloadQueueCalled = true
        reloadQueueCalledWith = callback
    }
}