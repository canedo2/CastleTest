import UIKit

class WindowCastleCollectionViewCell: UICollectionViewCell {

    static let cellId = String(describing: WindowCastleCollectionViewCell.self)
    static let cellSize = CGFloat((UIScreen.main.bounds.width - 20 - 7 * 10)/8)
    
    @IBOutlet private weak var windowNumberLabel: UILabel!
    @IBOutlet private weak var leftWingImageView: UIImageView!
    @IBOutlet private weak var rightWingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(number: Int, isLeftWingViewOpened: Bool, isRightWingOpened: Bool) {
        windowNumberLabel.text = "\(number)"
        leftWingImageView.image = isLeftWingViewOpened ? #imageLiteral(resourceName: "opened") : #imageLiteral(resourceName: "Closed")
        rightWingImageView.image = isRightWingOpened ? #imageLiteral(resourceName: "opened") : #imageLiteral(resourceName: "Closed")
    }

}
