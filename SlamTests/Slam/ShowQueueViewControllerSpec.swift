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

        describe("clicking the refresh queue button") {
            it("disables the buttons") {
                let refreshQueueButton = UIBarButtonItem()
                let addMatchToQueueButton = UIBarButtonItem()
                let tableView = UITableView()
                let controller = ShowQueueViewController()
                let manager = MockQueueManager()
                controller.currentQueue = tableView
                controller.queueManager = manager
                controller.refreshQueueButton = refreshQueueButton
                controller.addMatchToQueueButton = addMatchToQueueButton
                controller.clickRefreshQueue(controller.refreshQueueButton)
                expect(controller.refreshQueueButton.enabled).to(beFalse())
                expect(controller.addMatchToQueueButton.enabled).to(beFalse())
            }

            it("reloads the queue") {
                let refreshQueueButton = UIBarButtonItem()
                let addMatchToQueueButton = UIBarButtonItem()
                let tableView = UITableView()
                let controller = ShowQueueViewController()
                let manager = MockQueueManager()
                controller.currentQueue = tableView
                controller.queueManager = manager
                controller.refreshQueueButton = refreshQueueButton
                controller.addMatchToQueueButton = addMatchToQueueButton
                controller.clickRefreshQueue(refreshQueueButton)
                expect(manager.reloadQueueCalled).to(beTrue())
            }
        }

        describe("enable buttons") {
            it("reenables the functionality of the disable buttons") {
                let refreshQueueButton = UIBarButtonItem()
                let addMatchToQueueButton = UIBarButtonItem()
                let controller = ShowQueueViewController()
                refreshQueueButton.enabled = false
                addMatchToQueueButton.enabled = false
                controller.refreshQueueButton = refreshQueueButton
                controller.addMatchToQueueButton = addMatchToQueueButton
                controller.enableButtons()
                expect(refreshQueueButton.enabled).to(beTrue())
                expect(addMatchToQueueButton.enabled).to(beTrue())
            }
        }
    }
}