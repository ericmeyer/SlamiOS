import Slam

class MockSlamAPI: SlamAPI {
    var matches: [Match] = []
    var receivedGetQueue = false
    var wasMatchAdded = false
    var addMatchSuccessful = true
    var removeMatchWasCalled = false
    var loginSuccessful = true
    var wasLoginAttempted = false
    var removedMatchID: String?
    var loggedInEmail: String?
    var loggedInPassword: String?

    override func attemptLogin(email email: String, password: String, onSuccess: (Session) -> Void) {
        loggedInEmail = email
        loggedInPassword = password
        wasLoginAttempted = true
        if loginSuccessful {
            onSuccess(Session())
        }
    }

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