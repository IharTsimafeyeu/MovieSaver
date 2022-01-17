import UIKit

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
