import Slam

class MockSlamAPI: SlamAPI {
    var matches: [Match] = []
    var receivedGetCount = false
    var receivedGetMatchAtIndex = false
    var receivedGetQueue = false
    var wasMatchAdded = false
    var addMatchFailed = false

    override func getQueue(callback: ([Match]) -> Void) {
        receivedGetQueue = true
        callback(matches)
    }

    override func addMatch(playerOne: String, playerTwo: String, onSuccess: () -> Void) {
        if !addMatchFailed {
            wasMatchAdded = true
            onSuccess()
        }
    }
}