import Quick
import Nimble
import Slam
import UIKit

class QueueSpec: QuickSpec {
    override func spec() {
        describe("Queue") {
            it("is assigned an optional UITableView") {
                var display: UITableView? = UITableView()
                let subject = Queue(display: display)
                expect(subject.display).to(beIdenticalTo(display))
            }
        }
    }
}