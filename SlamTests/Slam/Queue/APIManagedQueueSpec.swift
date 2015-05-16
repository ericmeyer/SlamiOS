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
            var callbackCalled = false
            var callback = {() in
                callbackCalled = true
            }

            beforeEach({
                queueView = MockQueueView(display: UITableView())
                queueManager = APIManagedQueue(queueView: queueView!)
                mockAPI = MockSlamAPI(httpClient: MockHTTPClient())
                queueManager!.api = mockAPI!
                callbackCalled = false
            })

            describe("Loading the queue") {
                it("defers to the API to fetch the current queue") {
                    queueManager!.loadQueue(callback)

                    expect(mockAPI!.receivedGetQueue).to(beTrue())
                }

                it("shows the returned matches") {
                    queueManager!.loadQueue(callback)

                    expect(queueView!.wasShowMatchesCalled).to(beTrue())
                }
            }

            describe("Reloading the queue") {
                it("defers to the API to fetch the latest queue data") {
                    queueManager!.loadQueue(callback)
                    expect(mockAPI!.receivedGetQueue).to(beTrue())
                }

                it("executes the callback after the queue is updated") {
                    queueManager!.loadQueue(callback)
                    expect(callbackCalled).to(beTrue())
                }
            }
        }
    }
}