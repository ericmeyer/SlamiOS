import Quick
import Nimble
import Slam
import UIKit

class QueueManagerSpec: QuickSpec {
    override func spec() {
        describe("QueueManager") {
            it("takes a queue as an argument") {
                var display: UITableView?
                let queue = Queue(display: display)
                let subject = QueueManager(queue: queue)
                expect(subject.queue).to(beIdenticalTo(queue))
            }
        }
    }
}