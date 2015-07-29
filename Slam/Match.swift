public struct Match {
    public var id: String
    public var playerOne: String
    public var playerTwo: String


    public init(matchData: [String: String]) {
        id = matchData["id"]!
        playerOne = matchData["playerOne"]!
        playerTwo = matchData["playerTwo"]!
    }
}
