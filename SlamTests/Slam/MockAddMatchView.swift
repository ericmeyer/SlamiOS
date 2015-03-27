import Slam

class MockAddMatchView : AddMatchView {

    var wasToldMatchAdded : Bool
    var wasToldInputValid : Bool
    var wasToldInputInvalid : Bool

    init() {
        self.wasToldMatchAdded = false
        self.wasToldInputValid = false
        self.wasToldInputInvalid = false
    }

    func matchWasAdded() {
        self.wasToldMatchAdded = true
    }

    func inputIsValid() {
        self.wasToldInputValid = true
    }

    func inputIsInvalid() {
        self.wasToldInputInvalid = true
    }

}
