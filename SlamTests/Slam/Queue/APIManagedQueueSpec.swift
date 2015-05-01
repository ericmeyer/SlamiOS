import Quick
import Nimble
import Slam
import UIKit

class APIManagedQueueSpec: QuickSpec {
    override func spec() {
        describe("APIManagedQueue") {
            var queueView: MockQueueView?
            var mockAPI: MockSlamAPI?
            var queueManager: APIManagedQueue?

            beforeEach({
                queueView = MockQueueView(display: UITableView())
                queueManager = APIManagedQueue(queueView: queueView!)
                mockAPI = MockSlamAPI(httpClient: MockHTTPClient())
                queueManager!.api = mockAPI!
            })

            describe("Loading the queue") {
                it("defers to the API to fetch the current queue") {
                    queueManager!.loadQueue()

                    expect(mockAPI!.receivedGetQueue).to(beTrue())
                }

                it("shows the returned matches") {
                    queueManager!.loadQueue()

                    expect(queueView!.wasShowMatchesCalled).to(beTrue())
                }
            }

            describe("Reloading the queue") {
                var callbackCalled = false
                var callback = {() in
                    callbackCalled = true
                }

                beforeEach {
                    callbackCalled = false
                }

                it("defers to the API to fetch the latest queue data") {
                    queueManager!.reloadQueue(callback)
                    expect(mockAPI!.receivedGetQueue).to(beTrue())
                }

                it("executes the callback after the queue is updated") {
                    queueManager!.reloadQueue(callback)
                    expect(callbackCalled).to(beTrue())
                }
            }
        }
    }
}