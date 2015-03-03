import UIKit

public class ShowQueueViewController: UIViewController {

    @IBOutlet weak var currentQueue: UITableView!

    public var queueManager: QueueManager?
    public var queue: Queue?

    public override func viewDidLoad() {
        super.viewDidLoad()
        queue = Queue(display: currentQueue)
        queueManager = QueueManager(queue: queue!)
    }
}