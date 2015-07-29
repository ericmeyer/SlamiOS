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
            let matchData = ["id": "id", "playerOne": "One", "playerTwo": "Two"]

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

            describe("Editing a match") {

                context("When editing style is delete") {
                    it("removes the match from the view") {
                        let match = Match(matchData: matchData)
                        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                        queueView!.showMatches([match])
                        queueView!.tableView(display!, commitEditingStyle: .Delete, forRowAtIndexPath: indexPath)

                        expect(display!.wasRowDeleted).to(beTrue())
                        expect(queueView!.matches).to(beEmpty())
                    }

                    it("invokes the callback") {
                        let match = Match(matchData: matchData)
                        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                        var matchId = "0"
                        var onDelete = {(id) in
                            matchId = id
                        }
                        display = MockUITableView()
                        queueView = QueueView(display: display!, onDelete: onDelete)
                        queueView!.showMatches([match])

                        queueView!.tableView(display!, commitEditingStyle: .Delete, forRowAtIndexPath: indexPath)

                        expect(matchId).to(equal(match.id))
                    }
                }

                context("When editing style is not delete") {
                    it("does not invoke the callback") {
                        let match = Match(matchData: matchData)
                        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                        var matchDeleted = "0"
                        var onDelete = {
                            id in matchDeleted = id
                        }
                        display = MockUITableView()
                        queueView = QueueView(display: display!, onDelete: onDelete)
                        queueView!.showMatches([match])

                        queueView!.tableView(display!, commitEditingStyle: .Insert, forRowAtIndexPath: indexPath)

                        expect(matchDeleted).to(equal("0"))
                    }

                    it("does not remove the match from the view") {
                        let match = Match(matchData: matchData)
                        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                        queueView!.showMatches([match])
                        queueView!.tableView(display!, commitEditingStyle: .Insert, forRowAtIndexPath: indexPath)

                        expect(display!.wasRowDeleted).to(beFalse())
                        expect(queueView!.matches).toNot(beEmpty())
                    }
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

            context("after removing a match") {
                it("reloads the display") {
                    queueView!.removedMatch()

                    expect(display!.receivedReloadData).to(beTrue())
                }
            }
        }
    }
}