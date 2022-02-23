import UIKit

final class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    // MARK: - Properties
    private var filmsArray: [Film] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filmsArray = UserDefaultsManager.instance.getWatchedFilm()
    }
    // MARK: - Actions
    @IBAction func addNewFilm(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(
            withIdentifier: "AddNewFilmController") as? AddNewFilmController {
            viewController.delegate = self
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    // MARK: - Setups
    private func setupTableView() {
        title = "My Movie List"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.rowHeight = 212
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil),
                           forCellReuseIdentifier: TableViewCell.identifier)
    }
    private func ratingMovieInfo(_ indexPath: IndexPath) -> NSMutableAttributedString {
        let firstAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.manrope(ofSize: 18, weight: .bold)
        ]
        let secondAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1),
            NSAttributedString.Key.font: UIFont.manrope(ofSize: 18, weight: .light)
        ]
        let firstString = NSMutableAttributedString(
            string: "\(filmsArray[indexPath.row].rating)", attributes: firstAttributes
        )
        let secondString = NSAttributedString(string: "/10", attributes: secondAttributes)
        firstString.append(secondString)
        return firstString
    }
}
// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filmsArray.count
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UserDefaultsManager.instance.restoreDeletedFilm(deletedFilm:
                                                                self.filmsArray.remove(at: indexPath.row))
            UserDefaultsManager.instance.updateFilms(updatedFilm:
                                                        self.filmsArray)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.identifier, for: indexPath
        ) as? TableViewCell {
            cell.setupCellData(parameters: filmsArray[indexPath.row])
            cell.ratingFilmLabel.attributedText = ratingMovieInfo(indexPath)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailInfoController = storyboard.instantiateViewController(
            withIdentifier: "InfoAboutFilmController") as? InfoAboutFilmController {
            detailInfoController.film = filmsArray[indexPath.item]
            detailInfoController.modalPresentationStyle = .formSheet
            navigationController?.pushViewController(detailInfoController, animated: true)
        }
    }
}

// MARK: SaveFilmDelegate
extension ViewController: SaveFilmDelegate {
    func saveFilm(film: Film) {
        filmsArray.append(film)
    }
}
