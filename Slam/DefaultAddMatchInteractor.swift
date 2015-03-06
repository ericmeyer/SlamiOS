import Foundation

public class DefaultAddMatchInteractor : AddMatchInteractor {

    public init() {}

    public func attemptAdd(#playerOne: String, playerTwo: String) {
        NSLog("Adding %@ vs %@", playerOne, playerTwo)
    }

}
