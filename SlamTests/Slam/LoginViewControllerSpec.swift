import Slam
import Quick
import Nimble
import Foundation

class MockAuthenticationInteractor: NSObject, AuthenticationInteractor {

    var view: AuthenticationView?
    var wasToldToAttemptLogin = false
    var givenEmail = ""
    var givenPassword = ""

    func attemptLogin(#email: String, password: String) {
        wasToldToAttemptLogin = true
        givenEmail = email
        givenPassword = password
    }

}

class LoginViewControllerSpec: QuickSpec {
    override func spec() {

        func loadController(controllerID: String) -> UIViewController! {
            let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let bundle = NSBundle.mainBundle()
            let controller = storyboard.instantiateViewControllerWithIdentifier(controllerID) as! UIViewController
            return controller
        }

        describe("Loading the view") {
            it("injects dependencies via the Storyboard") {
                let controller = loadController("LoginViewController") as! LoginViewController
                expect(controller.interactor).notTo(beNil())
            }

            it("sets itself as the view for the authenticator") {
                let controller = loadController("LoginViewController") as! LoginViewController
                controller.viewDidLoad()
                expect(controller.interactor.view).notTo(beNil())
            }
        }

        describe("Attempting to log in") {
            var emailInput: UITextField!
            var passwordInput: UITextField!
            var controller: LoginViewController!

            beforeEach() {
                controller = LoginViewController()
                passwordInput = UITextField()
                emailInput = UITextField()
                controller.emailTextField = emailInput
                controller.passwordTextField = passwordInput
            }

            it("delegates to the interactor") {
                let interactor = MockAuthenticationInteractor()
                controller.interactor = interactor

                emailInput.text = "em@il.com"
                passwordInput.text = "12345"

                controller.attemptLogin()

                expect(interactor.wasToldToAttemptLogin).to(beTrue())
                expect(interactor.givenEmail).to(equal("em@il.com"))
                expect(interactor.givenPassword).to(equal("12345"))
            }
        }

        describe("Handling a successful login") {
            it("does not error") {
                let controller = loadController("LoginViewController") as! LoginViewController
                controller.loginWasSuccessful()
            }
        }
    }
}
