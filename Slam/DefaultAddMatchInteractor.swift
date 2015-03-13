import Foundation

public class DefaultAddMatchInteractor : AddMatchInteractor {

    let view : AddMatchView
    public init(view: AddMatchView) {
        self.view = view
    }

    public func attemptAdd(#playerOne: String, playerTwo: String) {
        NSLog("Adding %@ vs %@", playerOne, playerTwo)
        view.matchWasAdded()
    }

}
