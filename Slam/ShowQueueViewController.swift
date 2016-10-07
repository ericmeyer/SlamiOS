import UIKit

open class ShowQueueViewController: UIViewController {
    @IBOutlet weak open var currentQueue: UITableView!

    @IBOutlet open weak var refreshQueueButton: UIBarButtonItem!
    @IBOutlet open weak var addMatchToQueueButton: UIBarButtonItem!

    open var queueManager: QueueManager?
    open var queueView: QueueView?

    override open func viewDidLoad() {
        super.viewDidLoad()
        initializeDelegates()
    }

    override open func viewWillAppear(_ animated: Bool) {
        if (!self.isRunningTests()) {
            refreshQueue()
        }
    }

    open func initializeDelegates() {
        queueView = QueueView(display: currentQueue, onDelete: removeMatch)
        if queueManager == nil {
            queueManager = APIManagedQueue(
                queueView: queueView!
            )
        }
        currentQueue!.dataSource = queueView
    }

    @IBAction open func refreshQueue() {
        disableButtons()
        queueManager!.loadQueue(enableButtons)
    }

    open func enableButtons() {
        refreshQueueButton.isEnabled = true
        addMatchToQueueButton.isEnabled = true
    }

    open func disableButtons() {
        refreshQueueButton.isEnabled = false
        addMatchToQueueButton.isEnabled = false
    }

    @IBAction func cancelAddMatch(_ segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    fileprivate func removeMatch(_ matchId: String) {
        self.queueManager!.removeMatch(matchId)
    }

    fileprivate func isRunningTests() -> Bool {
        let env = ProcessInfo.processInfo.environment
        if let injectBundle = env["XCInjectBundle"] {
            return NSString(string: injectBundle).pathExtension == "xctest"
        }
        return false
    }
}
