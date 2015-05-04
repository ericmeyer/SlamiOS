import Quick
import Nimble
import Slam
import UIKit

class ShowQueueViewControllerSpec: QuickSpec {
    override func spec() {
        describe("Initializing delegates") {
            var tableView = UITableView()
            var controller = ShowQueueViewController()

            beforeEach {
                tableView = UITableView()
                controller = ShowQueueViewController()
                controller.currentQueue = tableView
            }

            it("creates the queue") {
                expect(controller.queue).to(beNil())

                controller.initializeDelegates()

                expect(controller.queue).notTo(beNil())
            }

            it("creates the queue manager with the queue") {
                expect(controller.queueManager).to(beNil())

                controller.initializeDelegates()

                let queueManager = controller.queueManager!
                expect(queueManager.queueView).to(beIdenticalTo(controller.queue))
            }
        }

        describe("clicking the refresh queue button") {
            var refreshQueueButton = UIBarButtonItem()
            var addMatchToQueueButton = UIBarButtonItem()
            var tableView = UITableView()
            var controller = ShowQueueViewController()
            var manager = MockQueueManager()

            beforeEach {
                refreshQueueButton = UIBarButtonItem()
                addMatchToQueueButton = UIBarButtonItem()
                tableView = UITableView()
                controller = ShowQueueViewController()
                manager = MockQueueManager()
                controller.currentQueue = tableView
                controller.queueManager = manager
                controller.refreshQueueButton = refreshQueueButton
                controller.addMatchToQueueButton = addMatchToQueueButton
            }

            it("disables the buttons") {
                controller.refreshQueue()
                expect(controller.refreshQueueButton.enabled).to(beFalse())
                expect(controller.addMatchToQueueButton.enabled).to(beFalse())
            }

            it("reloads the queue") {
                controller.refreshQueue()
                expect(manager.reloadQueueCalled).to(beTrue())
            }

            it("reenables the functionality of the disable buttons") {
                refreshQueueButton.enabled = false
                addMatchToQueueButton.enabled = false
                controller.enableButtons()
                expect(refreshQueueButton.enabled).to(beTrue())
                expect(addMatchToQueueButton.enabled).to(beTrue())
            }
        }
    }
}