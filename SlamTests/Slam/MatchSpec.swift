import Quick
import Nimble
import Slam

class MatchSpec: QuickSpec {
    override func spec() {
        describe("A match in the queue") {
            var match: Match?
            let matchData = ["id":"id","playerOne":"One","playerTwo":"Two"]

            beforeEach {
                match = Match(matchData: matchData)
            }

            it("has player one") {
                expect(match!.playerOne).to(equal("One"))
            }

            it("has player two") {
                expect(match!.playerTwo).to(equal("Two"))
            }

            it("has an id") {
                expect(match!.id).to(equal("id"))
            }
        }
    }
}