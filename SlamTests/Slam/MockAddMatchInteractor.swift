import Slam

public class MockAddMatchInteractor : AddMatchInteractor {

    var wasAddMatchCalled: Bool
    var givenPlayerOne: String?
    var givenPlayerTwo: String?

    public init() {
        self.wasAddMatchCalled = false
    }

    public func attemptAdd(#playerOne: String, playerTwo: String) {
        self.wasAddMatchCalled = true
        self.givenPlayerOne = playerOne
        self.givenPlayerTwo = playerTwo
    }

}