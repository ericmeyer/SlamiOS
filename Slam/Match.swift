public struct Match {
    public var playerOne: String
    public var playerTwo: String

    public init(matchData: [String: String]) {
        playerOne = matchData["playerOne"]!
        playerTwo = matchData["playerTwo"]!
    }
}
