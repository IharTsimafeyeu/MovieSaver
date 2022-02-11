import UIKit

protocol UpdateDateDelegate: AnyObject {
    func updateDate(date: String)
}

final class ReleaseDateController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private var datePicker: UIDatePicker!
    // MARK: - Properties
    weak var delegate: UpdateDateDelegate?
    // MARK: - Actions
    @IBAction private func saveDate(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        delegate?.updateDate(date: formatter.string(from: datePicker.date))
        navigationController?.popViewController(animated: true)
    }
}
