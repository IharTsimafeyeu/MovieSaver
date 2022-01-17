import UIKit

//MARK: UpdateYouTubeLinkDelegae
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


