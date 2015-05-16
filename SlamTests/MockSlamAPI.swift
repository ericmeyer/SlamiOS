import Slam

class MockSlamAPI: SlamAPI {
    var matches: [Match] = []
    var receivedGetQueue = false
    var wasMatchAdded = false
    var addMatchSuccessful = true

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
}