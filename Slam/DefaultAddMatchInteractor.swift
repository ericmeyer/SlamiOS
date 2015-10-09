public class DefaultAddMatchInteractor : AddMatchInteractor {

    let view : AddMatchView
    let api : SlamAPI

    public init(view: AddMatchView, api: SlamAPI) {
        self.view = view
        self.api = api
    }

    public func attemptAdd(playerOne playerOne: String, playerTwo: String) {
        api.addMatch(playerOne,
            playerTwo: playerTwo,
            onSuccess: {() -> Void in
                self.view.matchWasAdded()
        })

    }

    public func validateInput(playerOne playerOne: String, playerTwo: String) {
        if (playerOne == "" || playerTwo == "") {
            view.inputIsInvalid()
        } else {
            view.inputIsValid()
        }
    }

}
