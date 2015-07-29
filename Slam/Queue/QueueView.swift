import UIKit

public class QueueView: NSObject, UITableViewDataSource {
    let display: UITableView
    public let onDelete: (String) -> Void
    public var matches: [Match] = []

    public init(display: UITableView) {
        self.display = display
        self.onDelete = { _ in }
    }

    public init(display: UITableView, onDelete: (String) -> Void) {
        self.display = display
        self.onDelete = onDelete
    }

    public func showMatches(matches: [Match]) {
        self.matches = matches
        self.display.reloadData()
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let match = getMatch(indexPath)
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(match.playerOne) vs. \(match.playerTwo)"
        return cell
    }

    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let match = getMatch(indexPath)
            matches.removeAtIndex(indexPath.row)
            self.display.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            onDelete(match.id)
        }
    }

    private func getMatch(indexPath: NSIndexPath) -> Match {
        return matches[indexPath.row]
    }

    public func removedMatch() {
        self.display.reloadData()
    }
}
