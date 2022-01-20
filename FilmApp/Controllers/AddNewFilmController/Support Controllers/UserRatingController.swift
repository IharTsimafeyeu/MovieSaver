import UIKit

protocol UpdateRatingDelegate: AnyObject {
    func updateGrade(rating: String)
}

final class UserRatingController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var ratingPickerView: UIPickerView!
    
    // MARK: - Properties
    // MARK: Private
    private var ratingsArray = Array(11...100).map { Float($0) / 10 }
    private var stringOfPicker = ""
    
    weak var delegate: UpdateRatingDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingPickerView.dataSource = self
        ratingPickerView.delegate = self
    }
    
    // MARK: - Actions
    @IBAction private func saveRatingButton(_ sender: UIButton) {
        if stringOfPicker != "" {
            delegate?.updateGrade(rating: stringOfPicker)
            navigationController?.popViewController(animated: true)
        } else {
            alertForRatingPicker("Please select rating")
        }
    }
   
    // MARK: Private
    // MARK: - Helpers
    private func alertForRatingPicker(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
//MARK: UIPickerViewDataSource, UIPickerViewDelegate
extension UserRatingController: UIPickerViewDataSource, UIPickerViewDelegate  {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ratingsArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(ratingsArray[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stringOfPicker = "\(ratingsArray[row])"
    }
}

