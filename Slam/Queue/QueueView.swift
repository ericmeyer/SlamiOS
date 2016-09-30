import UIKit

open class QueueView: NSObject, UITableViewDataSource {
    let display: UITableView
    open let onDelete: (String) -> Void
    open var matches: [Match] = []

    public init(display: UITableView) {
        self.display = display
        self.onDelete = { _ in }
    }

    public init(display: UITableView, onDelete: @escaping (String) -> Void) {
        self.display = display
        self.onDelete = onDelete
    }

    open func showMatches(_ matches: [Match]) {
        self.matches = matches
        self.display.reloadData()
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let match = getMatch(indexPath)
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(match.playerOne) vs. \(match.playerTwo)"
        return cell
    }

    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let match = getMatch(indexPath)
            matches.remove(at: (indexPath as NSIndexPath).row)
            self.display.deleteRows(at: [indexPath], with: .automatic)
            onDelete(match.id)
        }
    }

    fileprivate func getMatch(_ indexPath: IndexPath) -> Match {
        return matches[(indexPath as NSIndexPath).row]
    }

    open func removedMatch() {
        self.display.reloadData()
    }
}
