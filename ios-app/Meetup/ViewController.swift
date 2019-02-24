import UIKit

class ViewController: UIViewController {
    init(api: API) {
        self.api = api
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented.")
    }

    private let api: API

    // MARK: - View

    @IBOutlet weak var status: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        load()
    }

    // MARK: Data Load

    private func load() {
        status.text = "Loading…"

        api.users { [weak self] response in
            guard let self = self else {
                return
            }

            switch response {
            case .success(let count):
                self.status.text = "Success: \(count) users!"
            case .failure(let error):
                self.status.text = "We failed: \(error)"
            }

        }
    }
}

