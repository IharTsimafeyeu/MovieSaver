import UIKit
// MARK: Public
// MARK: - API


protocol UpdateFilmNameDelegate: AnyObject {
    func updateName(filmName: String)
}

final class FilmNameController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var filmNameTextField: UITextField!
    
    // MARK: - Properties
    weak var delegate: UpdateFilmNameDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    // MARK: - Actions
    @IBAction private func saveFilmName(_ sender: UIButton) {
        if filmNameTextField.text != "" {
            let text = filmNameTextField.text ?? ""
            delegate?.updateName(filmName: text)
            navigationController?.popViewController(animated: true)
        } else {
            alertForFilmName("Please fill name movie")
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK: filmNameTextField.delegate
extension FilmNameController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
