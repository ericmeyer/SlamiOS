import UIKit

class MockUITableView: UITableView {
    var receivedReloadData = false
    var wasRowDeleted = false

    override func reloadData() {
        receivedReloadData = true
    }

    override func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        wasRowDeleted = true;
    }
}
