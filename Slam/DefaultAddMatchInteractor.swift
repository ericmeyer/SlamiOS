import Foundation

public class DefaultAddMatchInteractor : AddMatchInteractor {

    let view : AddMatchView
    public init(view: AddMatchView) {
        self.view = view
    }

    public func attemptAdd(#playerOne: String, playerTwo: String) {
        view.matchWasAdded()
    }

    public func validateInput(#playerOne: String, playerTwo: String) {
        if (playerOne == "" || playerTwo == "") {
            view.inputIsInvalid()
        } else {
            view.inputIsValid()
        }
    }

}
