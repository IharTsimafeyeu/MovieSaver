import Foundation

enum KeysUserDefaults {
   static let savefilm = "saveFilm"
   static let deleteFilm = "deleteFilm"
}

final class UserDefaultsManager {
    private let defaults = UserDefaults.standard
    static let instance = UserDefaultsManager()
    private func encode(watchedFilm: [Film], key: String) {
        if let encoderData = try? JSONEncoder().encode(watchedFilm) {
            return defaults.set(encoderData, forKey: key)
        }
    }
    private func decoder(key: String) -> [Film] {
        if let decoderData = defaults.data(forKey: key) {
            let watchedFilm = try? JSONDecoder().decode([Film].self, from: decoderData)
            if let resultFilm = watchedFilm {
                return resultFilm
            }
        }
        return[]
    }
    func getWatchedFilm() -> [Film] {
        decoder(key: KeysUserDefaults.savefilm)
    }
    func saveWatchedFilm(watchedFilm: Film) {
        var film = getWatchedFilm()
        film.insert(watchedFilm, at: 0)
        encode(watchedFilm: film, key: KeysUserDefaults.savefilm)
    }
    func updateFilms(updatedFilm: [Film]) {
        var films = getWatchedFilm()
        films = updatedFilm
        encode(watchedFilm: films, key: KeysUserDefaults.savefilm)
    }
    func restoreDeletedFilm(deletedFilm: Film) {
        var films = getWatchedFilm()
        films.append(deletedFilm)
        encode(watchedFilm: films, key: KeysUserDefaults.savefilm)
    }
}
