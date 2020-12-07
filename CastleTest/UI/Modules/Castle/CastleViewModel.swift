import RxSwift
import RxCocoa

class CastleViewModel: ViewModelType {
    
    var input: Input
    var output: Output
    private let bag = DisposeBag()
    
    private let castle:Castle
    
    private let visitorsEnteringSubject = PublishSubject<[Visitor]>()
    private let windowsSubject = BehaviorSubject<[Window]>(value: [])
    
    struct Input {
        var visitorsEntering:AnyObserver<[Visitor]>
    }
    
    struct Output {
        var windows:Driver<[Window]>
    }
    
    init(castle: Castle) {
        self.castle = castle
        input = Input(visitorsEntering: visitorsEnteringSubject.asObserver())
        output = Output(windows: windowsSubject.asDriver(onErrorJustReturn:[]))
        setupRx()
    }
    
    func setupRx() {
        windowsSubject.onNext(castle.windows)
        
        visitorsEnteringSubject.subscribe(onNext:{ [weak self] visitors in
            guard let self = self else { return }
            visitors.forEach{ self.castle.getVisitedBy(visitor: $0) }
            self.windowsSubject.onNext(self.castle.windows)
        }).disposed(by: bag)
    }
}
