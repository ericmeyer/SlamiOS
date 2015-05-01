import UIKit

public class ShowQueueViewController: UIViewController {
    @IBOutlet weak public var currentQueue: UITableView!

    public var queueManager: QueueManager?
    public var queue: QueueView?

    override public func viewDidLoad() {
        super.viewDidLoad()
        initializeDelegates()
        if (!self.isRunningTests()) {
            refreshQueue()
        }
    }

    public func initializeDelegates() {
        queue = QueueView(display: currentQueue)
        queueManager = QueueManager(queueView: queue!)
        currentQueue!.dataSource = queue
    }

    func refreshQueue() {
        queueManager!.loadQueue()
    }

    @IBAction func cancelAddMatch(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    private func isRunningTests() -> Bool {
        let environment = NSProcessInfo.processInfo().environment
        let injectBundle = environment["XCInjectBundle"] as! String?
        if let pathExtension = injectBundle?.pathExtension {
            return pathExtension == "xctest"
        } else {
            return false
        }
    }

}
