import Slam

class MockQueueView: QueueView {
    var wasShowMatchesCalled = false

    override func showMatches(matches: [Match]) {
        self.wasShowMatchesCalled = true
    }
}