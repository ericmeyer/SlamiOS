import Quick
import Nimble
import Slam

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

        describe("Validating the user input") {
            var view = MockAddMatchView()
            var interactor = DefaultAddMatchInteractor(
                view: view
            )

            beforeEach() {
                view = MockAddMatchView()
                interactor = DefaultAddMatchInteractor(
                    view: view
                )
            }

            it("lets the view know that the input is valid") {
                interactor.validateInput(
                    playerOne: "Eric",
                    playerTwo: "Taka"
                )

                expect(view.wasToldInputValid).to(beTrue())
            }

            it("is invalid with no player one") {
                interactor.validateInput(
                    playerOne: "",
                    playerTwo: "Taka"
                )

                expect(view.wasToldInputInvalid).to(beTrue())
            }

            it("is invalid with no player two") {
                interactor.validateInput(
                    playerOne: "Eric",
                    playerTwo: ""
                )

                expect(view.wasToldInputInvalid).to(beTrue())
            }
        }
    }

}
