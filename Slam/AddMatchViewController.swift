import UIKit

public class AddMatchViewController: UIViewController, AddMatchView {

    public var interactor : AddMatchInteractor?

    @IBOutlet weak public var playerOneInput: UITextField!
    @IBOutlet weak public var playerTwoInput: UITextField!

    override public func viewDidLoad() {
        super.viewDidLoad()
        interactor = DefaultAddMatchInteractor(
            view: self
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

}
