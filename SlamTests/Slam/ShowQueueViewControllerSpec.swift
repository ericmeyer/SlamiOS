import Quick
import Nimble
import Slam
import UIKit

class ShowQueueViewControllerSpec: QuickSpec {
    override func spec() {
        describe("Initializing delegates") {
            it("creates the queue") {
                let tableView = UITableView()
                let controller = ShowQueueViewController()
                controller.currentQueue = tableView
                expect(controller.queue).to(beNil())

                controller.initializeDelegates()

                expect(controller.queue).notTo(beNil())
            }

            it("creates the queue manager with the queue") {
                let tableView = UITableView()
                let controller = ShowQueueViewController()
                controller.currentQueue = tableView
                expect(controller.queueManager).to(beNil())

                controller.initializeDelegates()

                let queueManager = controller.queueManager!
                expect(queueManager.queueView).to(beIdenticalTo(controller.queue))
            }
        }
    }
}
