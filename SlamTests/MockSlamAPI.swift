import Slam

class MockSlamAPI: SlamAPI {
    var matches: [Match] = []
    var receivedGetQueue = false
    var wasMatchAdded = false
    var addMatchSuccessful = true
    var removeMatchWasCalled = false
    var removedMatchID: String?

    override func getQueue(callback: ([Match]) -> Void) {
        receivedGetQueue = true
        callback(matches)
    }

    override func addMatch(playerOne: String, playerTwo: String, onSuccess: () -> Void) {
        wasMatchAdded = true
        if addMatchSuccessful {
            onSuccess()
        }
    }

    override func removeMatchFromQueue(id: String, onSuccess: () -> Void) {
        removeMatchWasCalled = true
        removedMatchID = id
        onSuccess()
    }
}