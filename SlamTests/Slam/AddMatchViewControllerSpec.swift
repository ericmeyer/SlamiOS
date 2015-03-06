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

            var controller = AddMatchViewController()
            let interactor = MockAddMatchInteractor()

            beforeEach() {
                let bundle = NSBundle.mainBundle()
                let storyboard = UIStoryboard(name: "Main", bundle: bundle)
                controller = storyboard.instantiateViewControllerWithIdentifier("AddMatchController") as AddMatchViewController
                UIViewController().presentViewController(controller, animated: false, completion: nil)

                controller.interactor = interactor
            }

            it("delegates to the interactor") {
                controller.playerOneInput?.text = "Eric"
                controller.playerTwoInput?.text = "Taka"

                controller.addMatch()

                expect(interactor.wasAddMatchCalled).to(beTrue())
                expect(interactor.givenPlayerOne).to(equal("Eric"))
                expect(interactor.givenPlayerTwo).to(equal("Taka"))
            }
        }
    }
}
