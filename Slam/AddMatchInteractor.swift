public protocol AddMatchInteractor {

    func attemptAdd(#playerOne: String, playerTwo: String)
    func validateInput(#playerOne: String, playerTwo: String)

}