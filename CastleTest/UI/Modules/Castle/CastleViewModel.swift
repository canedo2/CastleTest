import RxSwift
import RxCocoa

class CastleViewModel: ViewModelType {
    
    var input: Input
    var output: Output
    private let bag = DisposeBag()
    
    private let castle:Castle
    
    //MARK: - Input
    private let visitorsEnteringSubject = PublishSubject<[Visitor]>()
    private let checkWinnersWithOpenWinsSubject = PublishSubject<Bool>()
    private let resetSubject = PublishSubject<Void>()
    
    //MARK: - Output
    private let windowsSubject = BehaviorSubject<[Window]>(value: [])
    private let winnersSubject = BehaviorSubject<(openWins:Bool, winners:[Int])?>(value: nil)
    
    struct Input {
        var visitorsEntering:AnyObserver<[Visitor]>
        var checkWinnersWithOpenWins:AnyObserver<Bool>
        var reset:AnyObserver<Void>
    }
    
    struct Output {
        var windows:Driver<[Window]>
        var winners:Driver<(openWins:Bool, winners:[Int])?>
    }
    
    init(castle: Castle) {
        self.castle = castle
        input = Input(visitorsEntering: visitorsEnteringSubject.asObserver(),
                      checkWinnersWithOpenWins: checkWinnersWithOpenWinsSubject.asObserver(),
                      reset: resetSubject.asObserver())
        output = Output(windows: windowsSubject.asDriver(onErrorJustReturn:[]),
                        winners: winnersSubject.asDriver(onErrorJustReturn:nil))
        setupRx()
    }
    
    func setupRx() {
        windowsSubject.onNext(castle.windows)
        
        visitorsEnteringSubject.subscribe(onNext:{ [weak self] visitors in
            guard let self = self else { return }
            visitors.forEach{ self.castle.getVisitedBy(visitor: $0) }
            self.windowsSubject.onNext(self.castle.windows)
        }).disposed(by: bag)
        
        checkWinnersWithOpenWinsSubject.subscribe(onNext:{ [weak self] openWins in
            guard let self = self else { return }
            self.winnersSubject.onNext((openWins: openWins, winners: self.castle.getWinners(openWins: openWins)))
        }).disposed(by: bag)
        
        resetSubject.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.castle.resetCastle()
            self.windowsSubject.onNext(self.castle.windows)
        }).disposed(by: bag)

    }
}
