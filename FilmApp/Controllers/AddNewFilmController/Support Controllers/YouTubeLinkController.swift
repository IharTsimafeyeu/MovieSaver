import UIKit

protocol UpdateYouTubeLinkDelegate: AnyObject {
    func updateURL(url: URL)
}



// MARK: - Properties
// MARK: Public
// MARK: Private

// MARK: - API


final class YouTubeLinkController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var urlTextField: UITextField!
    
    weak var delegate: UpdateYouTubeLinkDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextField.setUnderLine(.gray)
    }
    
    // MARK: - Actions
    @IBAction private func saveURLButton(_ sender: Any) {
        if urlTextField.text != "" && urlTextField.text?.isValidURL == true {
            let url = URL(string: urlTextField.text!)
            delegate?.updateURL(url: url!)
            navigationController?.popViewController(animated: true)
        } else {
            showAllert("Add url movie!")
            urlTextField.text = ""
        }
    }
    
    // MARK: - Setups
    // MARK: - Helpers
    private func validateUrl() -> Bool {
      let urlRegEx = "((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
      return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
    
    private func showAllert(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.urlTextField.setUnderLine(.red)
        }))
        present(alert, animated: true, completion: nil)
    }
}
