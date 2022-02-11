import UIKit

struct Film {
    var name: String
    var rating: String
    var date: String
    var image: UIImage
    var youtubeLink: URL
    var description: String
    init(name: String, rating: String, date: String, image: UIImage, youtubeLink: URL, description: String) {
        self.name = name
        self.rating = rating
        self.date = date
        self.image = image
        self.description = description
        self.youtubeLink = youtubeLink
    }
}
