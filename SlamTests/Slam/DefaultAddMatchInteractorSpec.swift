import Quick
import Nimble
import Slam

class DefaultAddMatchInteractorSpec: QuickSpec {

    override func spec() {
        describe("Adding a match to the queue") {
            it("exists") {
                let interactor = DefaultAddMatchInteractor()
                expect(interactor).notTo(beNil())

                interactor.attemptAdd(
                    playerOne: "Eric",
                    playerTwo: "Taka"
                )
            }
        }
    }

}
