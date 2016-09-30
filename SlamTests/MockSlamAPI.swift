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

    override func attemptLogin(email: String, password: String, onSuccess: @escaping (Session) -> Void) {
        loggedInEmail = email
        loggedInPassword = password
        wasLoginAttempted = true
        if loginSuccessful {
            onSuccess(Session())
        }
    }

    override func getQueue(_ callback: @escaping ([Match]) -> Void) {
        receivedGetQueue = true
        callback(matches)
    }

    override func addMatch(_ playerOne: String, playerTwo: String, onSuccess: @escaping () -> Void) {
        wasMatchAdded = true
        if addMatchSuccessful {
            onSuccess()
        }
    }

    override func removeMatchFromQueue(_ id: String, onSuccess: @escaping () -> Void) {
        removeMatchWasCalled = true
        removedMatchID = id
        onSuccess()
    }
}
