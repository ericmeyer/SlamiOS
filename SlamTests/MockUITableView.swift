import UIKit

class MockUITableView: UITableView {
    var receivedReloadData = false
    var wasRowDeleted = false

    override func reloadData() {
        receivedReloadData = true
    }

    override func deleteRowsAtIndexPaths(indexPaths: [AnyObject], withRowAnimation animation: UITableViewRowAnimation) {
        wasRowDeleted = true;
    }
}