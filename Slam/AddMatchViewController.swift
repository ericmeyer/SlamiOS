import UIKit

public class AddMatchViewController: UIViewController {

    public var interactor : AddMatchInteractor?

    @IBOutlet weak public var playerOneInput: UITextField!
    @IBOutlet weak public var playerTwoInput: UITextField!

    override public func viewDidLoad() {
        super.viewDidLoad()
        interactor = DefaultAddMatchInteractor()
    }

    @IBAction public func addMatch() {
        interactor?.attemptAdd(
            playerOne: playerOneInput!.text,
            playerTwo: playerTwoInput!.text
        )
    }

}
