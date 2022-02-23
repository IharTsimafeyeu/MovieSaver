import UIKit

struct Film: Codable {
    var name: String
    var rating: String
    var date: String
    var image: Data {
        didSet { _ = mainImage }
    }
    lazy var mainImage: UIImage = {
        UIImage(data: image)!
    }()
    var youtubeLink: String
    var description: String
}
