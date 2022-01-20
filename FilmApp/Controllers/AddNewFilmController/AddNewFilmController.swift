import UIKit

protocol SaveFilmDelegate: AnyObject {
    func saveFilm(film: Film)
}

final class AddNewFilmController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var filmNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var filmPhotoImageView: UIImageView!
    @IBOutlet weak var youtubeLinkLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: - Properties
    weak var delegate: SaveFilmDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDescription()
        addRecognizerForImageView()
        setupNavigationController()
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        filmPhotoImageView.layer.cornerRadius = filmPhotoImageView.frame.size.width / 2
    }
    
    //MARK: Setups
    private func setupNavigationController() {
        title = "Add new"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePhotoBarButton))
    }
    
    private func setupDescription() {
        descriptionTextView.layer.borderColor = UIColor.opaqueSeparator.cgColor
        descriptionTextView.layer.borderWidth = 1
    }
    
    private func addRecognizerForImageView() {
        let button = UITapGestureRecognizer(target: self, action: #selector(pickPhotoAction))
        filmPhotoImageView.isUserInteractionEnabled = true
        filmPhotoImageView.addGestureRecognizer(button)
    }
    
    //MARK: Actions
    @IBAction private func saveFilmBarButton(_ sender: Any) {
        let film = Film(name: filmNameLabel.text ?? "",
                        rating: ratingLabel.text ?? "",
                        date: releaseDateLabel.text ?? "",
                        image: filmPhotoImageView.image ?? UIImage(imageLiteralResourceName: "empty.png"),
                        youtubeLink: URL(string: youtubeLinkLabel.text!)!,
                        description: descriptionTextView.text ?? "")
        delegate?.saveFilm(film: film)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func userRatingButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let ratingController = storyboard.instantiateViewController(withIdentifier: "UserRatingController") as? UserRatingController {
            ratingController.delegate = self
            ratingController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(ratingController, animated: true)
        }
    }
    
    @IBAction private func changeNameButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let filmNameController = storyboard.instantiateViewController(withIdentifier: "FilmNameController") as? FilmNameController {
            filmNameController.delegate = self
            filmNameController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(filmNameController, animated: true)
        }
    }
    
    @IBAction private func releaseDateButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let releaseDateController = storyboard.instantiateViewController(withIdentifier: "ReleaseDateController") as? ReleaseDateController {
            releaseDateController.delegate = self
            releaseDateController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(releaseDateController, animated: true)
        }
    }
    
    @objc func savePhotoBarButton() {
        let film = Film(name: filmNameLabel.text ?? "",
                        rating: ratingLabel.text ?? "",
                        date: releaseDateLabel.text ?? "",
                        image: filmPhotoImageView.image ?? UIImage(imageLiteralResourceName: "empty.png"),
                        youtubeLink: URL(string: youtubeLinkLabel.text!)!,
                        description: descriptionTextView.text ?? "")
        delegate?.saveFilm(film: film)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func pickPhotoAction() {
        let alert = UIAlertController(title: "Choose image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func linkForYouTubeButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let youtubeLinkController = storyboard.instantiateViewController(withIdentifier: "YouTubeLinkController") as? YouTubeLinkController {
            youtubeLinkController.delegate = self
            youtubeLinkController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(youtubeLinkController, animated: true)
        }
    }
    
    //MARK: Helpers
    //MARK: Private
    private func alertForAddMovie(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "Your device don't have camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AddNewFilmController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage {
            filmPhotoImageView.image = image
        }
        if let image = info[.originalImage] as? UIImage {
            filmPhotoImageView.image = image
        }
    }
}

//MARK: UpdateYouTubeLinkDelegate
extension AddNewFilmController: UpdateYouTubeLinkDelegate {
    func updateURL(url: URL) {
        youtubeLinkLabel.text = url.absoluteString
    }
}

//MARK: UpdateRatingDelegate
extension AddNewFilmController: UpdateRatingDelegate {
    func updateGrade(rating: String) {
        ratingLabel.text = rating
    }
}

//MARK: UpdateDateDelegate
extension AddNewFilmController: UpdateDateDelegate {
    func updateDate(date: String) {
        releaseDateLabel.text = date
    }
}

//MARK: UpdateFilmNameDelegate
extension AddNewFilmController: UpdateFilmNameDelegate {
    func updateName(filmName: String) {
        filmNameLabel.text = filmName
    }
}

