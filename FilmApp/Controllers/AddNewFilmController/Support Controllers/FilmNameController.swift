import UIKit

enum PossibleErrors: Error {
    case overLimit
    case emptyField
}
// MARK: Public
// MARK: - API
protocol UpdateFilmNameDelegate: AnyObject {
    func updateName(filmName: String)
}

final class FilmNameController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private var filmNameTextField: UITextField!
    // MARK: - Properties
    weak var delegate: UpdateFilmNameDelegate?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }

    // MARK: - Actions
    @IBAction private func saveFilmName(_ sender: UIButton) {

        do {
            try checkText()
        } catch PossibleErrors.emptyField {
            alertForFilmName("Please fill movie name")
        } catch PossibleErrors.overLimit {
            alertForFilmName("It's incorrect text")
        } catch {
            print("Unexpected error")
        }
    }

    // MARK: - Helpers
    // MARK: Private
    private func alertForFilmName(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.filmNameTextField.setUnderLine(.red)
        }))
        present(alert, animated: true, completion: nil)
    }

    // MARK: Private
    // MARK: - Setups
    private func setupTextField() {
        filmNameTextField.delegate = self
        filmNameTextField.setUnderLine(.gray)
        filmNameTextField.keyboardType = .default
        filmNameTextField.autocapitalizationType = .sentences
    }
    private func checkText() throws {

        if filmNameTextField.text?.isEmpty == true {
            throw PossibleErrors.emptyField
        }
        if let text = filmNameTextField.text?.count {
            if text >= 15 {
                throw PossibleErrors.overLimit
            }
        }
        filmNameTextField.text = ""
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: filmNameTextField.delegate
extension FilmNameController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
