import Quick
import Nimble
import Slam
import UIKit

class AddMatchViewControllerSpec: QuickSpec {

    override func spec() {
        describe("Loading the view") {
            it("builds an interactor") {
                let controller = AddMatchViewController()
                let addMatchButton = UIButton()
                controller.addMatchButton = addMatchButton
                controller.viewDidLoad()
                expect(controller.interactor).toNot(beNil())
            }

            it("disables the add match button") {
                let controller = AddMatchViewController()
                let addMatchButton = UIButton()
                controller.addMatchButton = addMatchButton
                controller.viewDidLoad()
                expect(controller.addMatchButton.enabled).to(beFalse())
            }
        }

        describe("Adding a match to the queue") {

            var controller = AddMatchViewController()
            var playerOneInput = UITextField()
            var playerTwoInput = UITextField()
            var interactor = MockAddMatchInteractor()

            beforeEach() {
                controller = AddMatchViewController()
                playerOneInput = UITextField()
                playerTwoInput = UITextField()
                interactor = MockAddMatchInteractor()

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

        describe("Validating the input") {
            var controller = AddMatchViewController()
            var playerOneInput = UITextField()
            var playerTwoInput = UITextField()
            var addMatchButton = UIButton()
            var interactor = MockAddMatchInteractor()

            beforeEach() {
                controller = AddMatchViewController()
                playerOneInput = UITextField()
                playerTwoInput = UITextField()
                addMatchButton = UIButton()
                interactor = MockAddMatchInteractor()

                controller.playerOneInput = playerOneInput
                controller.playerTwoInput = playerTwoInput
                controller.addMatchButton = addMatchButton
                controller.interactor = interactor
            }

            it("tells the interactor to validate the input") {
                controller.playerOneInput!.text = "Eric"
                controller.playerTwoInput!.text = "Taka"

                controller.validateInput()

                expect(interactor.wasToldToValidateInput).to(beTrue())
                expect(interactor.givenPlayerOne).to(equal("Eric"))
                expect(interactor.givenPlayerTwo).to(equal("Taka"))
            }

            it("disables the add match button when the input is invalid") {
                controller.inputIsInvalid()

                expect(controller.addMatchButton.enabled).to(beFalse())
            }

            it("enables the add match button when the input is valid") {
                controller.inputIsInvalid()
                controller.inputIsValid()

                expect(controller.addMatchButton.enabled).to(beTrue())
            }
        }

        describe("After a match was added") {
            it("dismisses the controller") {
                let originalController = UIViewController()
                let navController = UINavigationController(
                    rootViewController: originalController
                )

                let controller = AddMatchViewController()
                navController.pushViewController(controller, animated: false)

                expect(navController.visibleViewController).to(equal(controller))
                controller.matchWasAdded()
                expect(navController.visibleViewController).to(equal(originalController))
            }
        }
    }
}
