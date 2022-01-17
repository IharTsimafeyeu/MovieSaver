import UIKit

extension UIFont {
    static func manrope(ofSize size: CGFloat, weight: FontWeight) -> UIFont {
        return UIFont(name: weight.rawValue, size: size)!
    }
}
