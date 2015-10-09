import Slam

class MockAddMatchInteractor : AddMatchInteractor {

    var wasAddMatchCalled: Bool
    var givenPlayerOne: String?
    var givenPlayerTwo: String?
    var wasToldToValidateInput: Bool

    init() {
        self.wasAddMatchCalled = false
        self.wasToldToValidateInput = false
    }

    func attemptAdd(playerOne playerOne: String, playerTwo: String) {
        self.wasAddMatchCalled = true
        self.givenPlayerOne = playerOne
        self.givenPlayerTwo = playerTwo
    }

    func validateInput(playerOne playerOne: String, playerTwo: String) {
        self.wasToldToValidateInput = true
        self.givenPlayerOne = playerOne
        self.givenPlayerTwo = playerTwo
    }

}
