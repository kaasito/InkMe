
import UIKit
extension UIImageView {

    func circleImageView() {
       layer.borderColor = UIColor.white.cgColor
       layer.borderWidth = 2
       contentMode = .scaleAspectFill
       layer.cornerRadius = self.frame.height / 2
       layer.masksToBounds = false
       clipsToBounds = true
    }
}
