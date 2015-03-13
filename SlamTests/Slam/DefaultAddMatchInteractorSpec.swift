import Quick
import Nimble
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
class DefaultAddMatchInteractorSpec: QuickSpec {

    override func spec() {
        describe("Adding a match to the queue") {
            it("lets the view know that a match was added") {
                let view = MockAddMatchView()
                let interactor = DefaultAddMatchInteractor(
                    view: view
                )

                interactor.attemptAdd(
                    playerOne: "Eric",
                    playerTwo: "Taka"
                )

                expect(view.wasToldMatchAdded).to(beTrue())
            }
        }
    }

}
