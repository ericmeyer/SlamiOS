import Quick
import Nimble
import Slam
import UIKit

class QueueManagerSpec: QuickSpec {
    override func spec() {
        describe("QueueManager") {

            describe("Loading the queue") {
                var queueView: MockQueueView?
                var mockAPI: MockSlamAPI?
                var queueManager: QueueManager?

                beforeEach({
                    queueView = MockQueueView(display: UITableView())
                    queueManager = QueueManager(queueView: queueView!)
                    mockAPI = MockSlamAPI(httpClient: MockHTTPClient())
                    queueManager!.api = mockAPI!
                })

                it("defers to the API to fetch the current queue") {
                    queueManager!.loadQueue()

                    expect(mockAPI!.receivedGetQueue).to(beTrue())
                }

                it("shows the returned matches") {
                    queueManager!.loadQueue()

                    expect(queueView!.wasShowMatchesCalled).to(beTrue())
                }
            }
        }
    }
}