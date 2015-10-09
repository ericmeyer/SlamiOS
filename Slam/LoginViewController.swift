import UIKit

public class LoginViewController: UIViewController, AuthenticationView {

    @IBOutlet weak public var emailTextField: UITextField!
    @IBOutlet weak public var passwordTextField: UITextField!
    @IBOutlet public var interactor: AuthenticationInteractor!

    public override func viewDidLoad() {
        interactor.view = self
    }

    @IBAction public func attemptLogin() {
        interactor.attemptLogin(
            email: emailTextField.text!,
            password: passwordTextField.text!
        )
    }

    public func loginWasSuccessful() {
        self.performSegueWithIdentifier("showQueue", sender: self)
    }

}
