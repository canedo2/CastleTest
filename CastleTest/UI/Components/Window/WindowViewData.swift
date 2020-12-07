import RxDataSources
    
struct WindowViewData: IdentifiableType, Equatable {
    typealias Identity = Int
    
    var identity: Int { number }
    let number: Int
    let isRightWingOpened: Bool
    let isLeftWingOpened: Bool
    
    init(window: Window) {
        self.number = window.number
        self.isLeftWingOpened = window.isLeftWingOpened
        self.isRightWingOpened = window.isRightWingOpened
    }
}
