import UIKit

public class AddMatchViewController: UIViewController, AddMatchView {

    public var interactor : AddMatchInteractor?

    @IBOutlet weak public var playerOneInput: UITextField!
    @IBOutlet weak public var playerTwoInput: UITextField!
    @IBOutlet weak public var addMatchButton: UIButton!

    override public func viewDidLoad() {
        super.viewDidLoad()
        interactor = DefaultAddMatchInteractor(
            view: self,
            api: SlamAPI(httpClient: AsynchronousHTTPClient())
        )
        addMatchButton.enabled = false
    }

    @IBAction public func validateInput() {
        interactor?.validateInput(
            playerOne: playerOneInput!.text,
            playerTwo: playerTwoInput!.text
        )
    }

    @IBAction public func addMatch() {
        interactor?.attemptAdd(
            playerOne: playerOneInput!.text,
            playerTwo: playerTwoInput!.text
        )
    }

    public func matchWasAdded() {
        NSLog("Refresh/show the updated queue")
    }

    public func inputIsValid() {
        addMatchButton.enabled = true
    }

    public func inputIsInvalid() {
        addMatchButton.enabled = false
    }

}
