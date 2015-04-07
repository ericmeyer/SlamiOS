import UIKit

class MockUITableView: UITableView {
    var receivedReloadData = false

    override func reloadData() {
        receivedReloadData = true
    }
}