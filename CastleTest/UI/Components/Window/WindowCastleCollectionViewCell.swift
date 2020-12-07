import UIKit

class WindowCastleCollectionViewCell: UICollectionViewCell {

    static let cellId = String(describing: WindowCastleCollectionViewCell.self)
    static let cellSize = CGFloat((UIScreen.main.bounds.width - 20 - 7 * 10)/8)
    
    @IBOutlet private weak var windowNumberLabel: UILabel!
    @IBOutlet private weak var leftWingView: UIView!
    @IBOutlet private weak var rightWingView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(number: Int, isLeftWingViewOpened: Bool, isRightWingOpened: Bool) {
        windowNumberLabel.text = "\(number)"
        leftWingView.backgroundColor = isLeftWingViewOpened ? .clear : .gray
        rightWingView.backgroundColor = isRightWingOpened ? .clear : .gray
    }

}
