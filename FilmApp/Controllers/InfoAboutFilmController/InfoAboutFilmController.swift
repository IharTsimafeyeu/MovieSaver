import UIKit
import WebKit

// MARK: - Helpers
final class InfoAboutFilmController: UIViewController {
    // MARK: Public
    // MARK: Properties
    public var film: Film?
    private var trailerFilm = ""
    // MARK: - Outlets
    @IBOutlet private var filmImageView: UIImageView!
    @IBOutlet private var filmNameLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var filmVideoWebView: WKWebView!
    @IBOutlet private var ratingAndDateLabel: UILabel!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addInfoToItems()
        addSubviews()
    }

    // MARK: - Setups
    // MARK: Private
    private func addInfoToItems() {
        if let film = film {
            filmNameLabel.text = film.name
            filmImageView.image = film.image
            descriptionTextView.text = film.description
            addInfoToYear()
        }
//        guard let url = film?.youtubeLink else { return }
        guard let url = URL(string: "https://www.youtube.com/\(film?.youtubeLink)") else { return }
        filmVideoWebView.load(URLRequest(url: url))
    }

    private func addSubviews() {
        descriptionTextView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        descriptionTextView.layer.borderWidth = 1
    }

    private func addInfoToYear() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "Star.png")
        let attachmentString = NSMutableAttributedString(attachment: attachment)
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.manrope(ofSize: 14, weight: .bold)
        ]
        let secondAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.manrope(ofSize: 14, weight: .light)
        ]
        let thirdAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1),
            NSAttributedString.Key.font: UIFont.manrope(ofSize: 14, weight: .light)
        ]
        guard let film = film else { return }
        let firstString = NSMutableAttributedString(string: "  \(film.rating)", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "/10", attributes: secondAttributes)
        let thirdString = NSAttributedString(string: " \(film.date)", attributes: thirdAttributes)
        attachmentString.append(firstString)
        attachmentString.append(secondString)
        attachmentString.append(thirdString)
        ratingAndDateLabel.attributedText = attachmentString
    }
}
