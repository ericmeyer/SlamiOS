import Slam

class MockAddMatchView : AddMatchView {

    var wasToldMatchAdded : Bool

    init() {
        self.wasToldMatchAdded = false
    }

    func matchWasAdded() {
        self.wasToldMatchAdded = true
    }

}
