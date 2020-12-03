import RxSwift

class CastleViewModel: ViewModelType {
    
    var input: Input
    var output: Output
    private let bag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init() {
        input = Input()
        output = Output()
    }
}
