import Slam

class MockQueueView: QueueView {
    var wasShowMatchesCalled = true

    override func showMatches(matches: [Match]) {
        self.wasShowMatchesCalled = true
    }
}