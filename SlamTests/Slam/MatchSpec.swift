import Quick
import Nimble
import Slam

class MatchSpec: QuickSpec {
    override func spec() {
        describe("A match in the queue") {
            it("has player one") {
                let matchData = ["playerOne":"One","playerTwo":"Two"]
                let match = Match(matchData: matchData)
                expect(match.playerOne).to(equal("One"))
            }

            it("has player two") {
                let matchData = ["playerOne":"One","playerTwo":"Two"]
                let match = Match(matchData: matchData)
                expect(match.playerTwo).to(equal("Two"))
            }
        }
    }
}