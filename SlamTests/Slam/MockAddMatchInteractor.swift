import Slam

public class MockAddMatchInteractor : AddMatchInteractor {

    var wasAddMatchCalled: Bool
    var givenPlayerOne: String?
    var givenPlayerTwo: String?
    var wasToldToValidateInput: Bool

    public init() {
        self.wasAddMatchCalled = false
        self.wasToldToValidateInput = false
    }

    public func attemptAdd(#playerOne: String, playerTwo: String) {
        self.wasAddMatchCalled = true
        self.givenPlayerOne = playerOne
        self.givenPlayerTwo = playerTwo
    }

    public func validateInput(#playerOne: String, playerTwo: String) {
        self.wasToldToValidateInput = true
        self.givenPlayerOne = playerOne
        self.givenPlayerTwo = playerTwo
    }

}