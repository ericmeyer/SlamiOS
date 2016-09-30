import UIKit

open class LoginViewController: UIViewController, AuthenticationView {

    @IBOutlet weak open var emailTextField: UITextField!
    @IBOutlet weak open var passwordTextField: UITextField!
    @IBOutlet open var interactor: AuthenticationInteractor!

    open override func viewDidLoad() {
        interactor.view = self
    }

    @IBAction open func attemptLogin() {
        interactor.attemptLogin(
            email: emailTextField.text!,
            password: passwordTextField.text!
        )
    }

    open func loginWasSuccessful() {
        self.performSegue(withIdentifier: "showQueue", sender: self)
    }

}
