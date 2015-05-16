import Quick
import Nimble
import Slam

class DefaultAddMatchInteractorSpec: QuickSpec {

    override func spec() {
        var view = MockAddMatchView()
        var api = MockSlamAPI(httpClient: MockHTTPClient())
        var interactor = DefaultAddMatchInteractor(
            view: view,
            api: api
        )

        beforeEach() {
            view = MockAddMatchView()
            api = MockSlamAPI(httpClient: MockHTTPClient())
            interactor = DefaultAddMatchInteractor(
                view: view,
                api: api
            )
        }

        describe("Adding a match to the queue") {
            it("defers to the api to add a match") {
                interactor.attemptAdd(
                    playerOne: "Eric",
                    playerTwo: "Taka"
                )

                expect(api.wasMatchAdded).to(beTrue())
            }

            it("lets the view know that a match was added") {
                api.addMatchSuccessful = true

                interactor.attemptAdd(
                    playerOne: "Eric",
                    playerTwo: "Taka"
                )

                expect(view.wasToldMatchAdded).to(beTrue())
            }

            it("does not let view know the match was added when adding a match fails"){
                api.addMatchSuccessful = false

                interactor.attemptAdd(
                    playerOne: "Eric",
                    playerTwo: "Taka"
                )

                expect(view.wasToldMatchAdded).to(beFalse())
            }
        }

        describe("Validating the user input") {
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
