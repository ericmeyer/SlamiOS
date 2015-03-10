import Quick
import Nimble
import Slam
import UIKit

class AddMatchViewControllerSpec: QuickSpec {

    override func spec() {
        describe("Loading the view") {
            it("builds an interactor") {
                let controller = AddMatchViewController()
                controller.viewDidLoad()
                expect(controller.interactor).toNot(beNil())
            }
        }

        describe("Adding a match to the queue") {

            let controller = AddMatchViewController()
            let playerOneInput = UITextField()
            let playerTwoInput = UITextField()
            let interactor = MockAddMatchInteractor()

            beforeEach() {
                controller.playerOneInput = playerOneInput
                controller.playerTwoInput = playerTwoInput
                controller.interactor = interactor
            }

            it("delegates to the interactor") {
                controller.playerOneInput!.text = "Eric"
                controller.playerTwoInput!.text = "Taka"

                controller.addMatch()

                expect(interactor.wasAddMatchCalled).to(beTrue())
                expect(interactor.givenPlayerOne).to(equal("Eric"))
                expect(interactor.givenPlayerTwo).to(equal("Taka"))
            }
        }
    }
}
