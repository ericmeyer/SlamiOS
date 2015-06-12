import UIKit

public class QueueView: NSObject, UITableViewDataSource {
    let display: UITableView
    public var matches: [Match] = []

    public init(display: UITableView) {
        self.display = display
    }

    public func showMatches(matches: [Match]) {
        self.matches = matches
        self.display.reloadData()
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let match = matches[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(match.playerOne) vs. \(match.playerTwo)"
        return cell
    }

    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            matches.removeAtIndex(indexPath.row)
            self.display.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
