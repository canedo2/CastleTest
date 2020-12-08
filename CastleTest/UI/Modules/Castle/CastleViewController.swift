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
    
    @IBOutlet weak var openedCountLabel: UILabel!
    @IBOutlet weak var leftCountLabel: UILabel!
    @IBOutlet weak var rightCountLabel: UILabel!
    @IBOutlet weak var closedCountLabel: UILabel!
    
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
        
        viewModel?.output.windows.flatMap({ [weak self] windows -> Driver<[SectionOfWindows]> in
            let openedCount = windows.filter { $0.isOpened }.count
            let leftCount = windows.filter { $0.isLeftWingOpened && !$0.isOpened }.count
            let rightCount = windows.filter { $0.isRightWingOpened && !$0.isOpened }.count
            let closedCount = windows.filter { $0.isClosed }.count
            
            self?.openedCountLabel.text = "A:\(openedCount)"
            self?.leftCountLabel.text = "I:\(leftCount)"
            self?.rightCountLabel.text = "D:\(rightCount)"
            self?.closedCountLabel.text = "C:\(closedCount)"
            
            let windowsViewData = windows.map { WindowViewData(window: $0) }
            let sectionOfWindows = SectionOfWindows(header: "Windows", items: windowsViewData)
            return Driver.of([sectionOfWindows])
        }).drive(collectionView.rx.items(dataSource: dataSource))
        .disposed(by: bag)
        
        viewModel?.output.winners
            .filter({ $0 != nil})
            .drive(onNext: { winnersInfo in
                let title = winnersInfo!.openWins ? "Ganadores por reglas inciales" : "Ganadores todos los abiertos ganan"
                let winners = winnersInfo!.winners
                let winnersCount = winners.count
                let message = winnersCount > 0 ? "Los ganadores son:\n\(winners.map{"\($0)"}.joined(separator: " - "))" : "No hay ganadores"
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
        }).disposed(by: bag)
    }
    
    @IBAction func startVisiting(_ sender: UIButton) {
        var visitors = [Visitor]()
        for braceletNumber in 1...Castle.totalWindowsCount {
            visitors.append(Visitor(braceletNumber: braceletNumber))
        }
        viewModel?.input.visitorsEntering.onNext(visitors)
    }
    
    @IBAction func showWinners(_ sender: UIButton) {
        let alert = UIAlertController(title: "Tipo de ganador", message: "¿Qué tipo de ganador quieres declarar?", preferredStyle: .actionSheet)
        let actionFirstRules = UIAlertAction(title: "Reglas iniciales", style: .default) { _ in
            self.viewModel?.input.checkWinnersWithOpenWins.onNext(false)
        }
        let actionAnyOpenedWins = UIAlertAction(title: "Abiertos ganan", style: .default) { _ in
            self.viewModel?.input.checkWinnersWithOpenWins.onNext(true)
        }
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(actionFirstRules)
        alert.addAction(actionAnyOpenedWins)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        self.viewModel?.input.reset.onNext(())
    }
    
}

