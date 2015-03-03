import Quick
import Nimble
import Slam

class ShowQueueViewControllerSpec: QuickSpec {
    override func spec() {
        context("#viewDidLoad") {
            it("creates the queue") {
                let subject = ShowQueueViewController()
                expect(subject.queue).to(beNil())
                let noop = subject.view
                expect(subject.queue).notTo(beNil())
            }

            it("creates the queueManager with the queue") {
                let subject = ShowQueueViewController()
                expect(subject.queueManager).to(beNil())
                let noop = subject.view
                let queueManager = subject.queueManager!
                expect(queueManager.queue).to(beIdenticalTo(subject.queue))
            }
        }
    }
}