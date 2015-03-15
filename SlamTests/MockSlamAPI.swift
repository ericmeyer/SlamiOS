import Slam

class MockSlamAPI: SlamAPI {
    var matches: [Match] = []
    var receivedGetCount = false
    var receivedGetMatchAtIndex = false
    var receivedGetQueue = false

    override func getQueue(callback: ([Match]) -> Void) {
        receivedGetQueue = true
        callback(matches)
    }
}