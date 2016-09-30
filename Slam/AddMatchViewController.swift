import UIKit

open class AddMatchViewController: UIViewController, AddMatchView {

    open var interactor : AddMatchInteractor?

    @IBOutlet weak open var playerOneInput: UITextField!
    @IBOutlet weak open var playerTwoInput: UITextField!
    @IBOutlet weak open var addMatchButton: UIButton!

    override open func viewDidLoad() {
        super.viewDidLoad()
        interactor = DefaultAddMatchInteractor(
            view: self,
            api: SlamAPI(httpClient: AsynchronousHTTPClient())
        )
        addMatchButton.isEnabled = false
    }

    @IBAction open func validateInput() {
        interactor?.validateInput(
            playerOne: playerOneInput!.text!,
            playerTwo: playerTwoInput!.text!
        )
    }

    @IBAction open func addMatch() {
        interactor?.attemptAdd(
            playerOne: playerOneInput!.text!,
            playerTwo: playerTwoInput!.text!
        )
    }

    open func matchWasAdded() {
        self.dismiss(animated: true, completion: nil)
        self.removeFromParentViewController()
    }

    open func inputIsValid() {
        addMatchButton.isEnabled = true
    }

    open func inputIsInvalid() {
        addMatchButton.isEnabled = false
    }

}
