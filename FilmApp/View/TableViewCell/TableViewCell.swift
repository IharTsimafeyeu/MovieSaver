import UIKit

final class TableViewCell: UITableViewCell {
    
    // MARK: - Properties
    // MARK: Public
    static let identifier = "TableViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filmLogoImageView: UIImageView!
    @IBOutlet weak var filmNameLabel: UILabel!
    @IBOutlet weak var ratingFilmLabel: UILabel!
    
    //MARK: - Lifecycle 
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadowForCell()
    }
    
    // MARK: - Setups
    func setupCellData(parameters: Film) {
        filmNameLabel.text = parameters.name
        ratingFilmLabel.text = parameters.rating
        filmLogoImageView.image = parameters.image
}
    func setupShadowForCell() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 1
    }
    
}
