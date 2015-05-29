import Quick
import Nimble
import Slam
import UIKit

class QueueViewSpec: QuickSpec {
    override func setUp() {
        continueAfterFailure = false
    }

    override func spec() {
        describe("QueueView") {
            var display: MockUITableView?
            var queueView: QueueView?
            let matchData = ["id":"id", "playerOne":"One","playerTwo":"Two"]

            beforeEach {
                display = MockUITableView()
                queueView = QueueView(display: display!)
            }

            describe("The number of rows") {
                it("is equal to the number of matches") {
                    queueView!.matches = [Match(matchData: matchData)]
                    expect(queueView!.tableView(display!, numberOfRowsInSection: 0)).to(equal((1)))
                }
            }

            describe("Building a table view cell") {
                it("includes player one in the cell's label") {
                    let match = Match(matchData: matchData)
                    queueView!.showMatches([match])
                    let cell = queueView!.tableView(display!, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
                    expect(cell.textLabel!.text).to(contain("One"))
                }

                it("includes player two in the cell's label") {
                    let match = Match(matchData: matchData)
                    queueView!.showMatches([match])
                    let cell = queueView!.tableView(display!, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
                    expect(cell.textLabel!.text).to(contain("Two"))
                }
            }

            context("Showing a new list of matches") {
                it("sets the matches") {
                    let match = Match(matchData: matchData)

                    queueView!.showMatches([match])

                    expect(queueView!.matches.count).to(equal(1))
                    expect(queueView!.matches[0].playerOne).to(equal("One"))
                }

                it("reloads the display") {
                    queueView!.showMatches([])

                    expect(display!.receivedReloadData).to(beTrue())
                }
            }
        }
    }
}