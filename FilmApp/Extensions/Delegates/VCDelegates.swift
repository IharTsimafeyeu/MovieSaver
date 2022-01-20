import UIKit

//MARK: SaveFilmDelegate
extension ViewController: SaveFilmDelegate {
    func saveFilm(film: Film) {
        filmsArray.append(film)
        tableView.reloadData()
    }
}

