import UIKit

//MARK: SaveFilmDelegate
extension ViewController: SaveFilmDelegate {
    func saveFilm(film: Film) {
//        UserDefaults.standard.set(film, forKey: Constant.Defaults.infoAboutFilm)
        filmsArray.append(film)
        tableView.reloadData()
    }
}
