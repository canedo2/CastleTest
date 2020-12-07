import UIKit
import RxSwift
import RxCocoa
import RxDataSources

extension Assembler {
    func assembleCastleViewController() -> CastleViewController {
        let castleVC = CastleViewController()
        castleVC.viewModel = CastleViewModel(castle: Assembler.assembly.castle)
        return castleVC
    }
}


class CastleViewController: BaseViewController {
    var viewModel: CastleViewModel?
    private let bag = DisposeBag()
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: String(describing:WindowCastleCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: WindowCastleCollectionViewCell.cellId)
           
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: WindowCastleCollectionViewCell.cellSize, height: WindowCastleCollectionViewCell.cellSize)
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
            collectionView.collectionViewLayout = layout
        }
    }
    
    let dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionOfWindows> { (section, collectionView, indexPath, item) -> UICollectionViewCell in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WindowCastleCollectionViewCell.cellId, for: indexPath) as? WindowCastleCollectionViewCell else { fatalError("WindowCollectionViewCell not getting generated/dequeued")
        }
        cell.configure(number: item.number, isLeftWingViewOpened: item.isLeftWingOpened, isRightWingOpened: item.isRightWingOpened)
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    func setupRx() {
        
        var visitors = [Visitor]()
        for braceletNumber in 1...Castle.totalWindowsCount {
            visitors.append(Visitor(braceletNumber: braceletNumber))
        }
        viewModel?.input.visitorsEntering.onNext(visitors)
        
        viewModel?.output.windows.flatMap({ windows -> Driver<[SectionOfWindows]> in
            let windowsViewData = windows.map { WindowViewData(window: $0) }
            let sectionOfWindows = SectionOfWindows(header: "Windows", items: windowsViewData)
            return Driver.of([sectionOfWindows])
        }).drive(collectionView.rx.items(dataSource: dataSource))
        .disposed(by: bag)
    }
}

