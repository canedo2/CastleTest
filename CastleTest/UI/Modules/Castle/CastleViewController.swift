import UIKit

extension Assembler {
    func assembleCastleViewController() -> CastleViewController {
        let castleVC = CastleViewController()
        castleVC.viewModel = CastleViewModel()
        return castleVC
    }
}


class CastleViewController: BaseViewController {
    var viewModel: CastleViewModel?
    @IBOutlet weak var collectionView: UICollectionView!
}

