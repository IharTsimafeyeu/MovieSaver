import UIKit
//import Photos
//import PhotosUI

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
        addSubviews()
        addRecognizerForImageView()
        title = "Add new"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: Setups
    private func addSubviews() {
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


//extension AddNewFilmController: PHPickerViewControllerDelegate {
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        dismiss(animated: true, completion: nil)
//        for item in results {
//            item.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
//
//                if let image = image as? UIImage {
//                    print(image)
//
//                    DispatchQueue.main.async {
//                        self.filmPhotoImageView?.image = image
//                    }
//                }
//            }
//        }
//    }
//}

//    private func presentPickerView() {
//        var configuration: PHPickerConfiguration = PHPickerConfiguration()
//        configuration.filter = PHPickerFilter.images
//        configuration.selectionLimit = 1
//
//        let picker: PHPickerViewController = PHPickerViewController(configuration: configuration)
//        picker.delegate = self
//        present(picker, animated: true, completion: nil)
//    }
//
