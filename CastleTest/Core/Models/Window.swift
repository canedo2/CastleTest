enum WindowState:String {
    case closed = "C"
    case opened = "A"
    case leftWingOpened = "I"
    case rightWingOpened = "D"
}

class Window {
    let number: Int
    var isRightWingOpened: Bool = true
    var isLeftWingOpened: Bool = true
    
    var previousNumber: Int {
        if number == 1 { return Castle.totalWindowsCount } //New business rule
        else { return number - 1 }
    }
    
    var nextNumber: Int {
        if number == Castle.totalWindowsCount { return 1 } //New business rule
        else { return number + 1 }
    }
    
    var isOpened: Bool {
        return isRightWingOpened && isLeftWingOpened
    }
    var isClosed: Bool {
        return !isRightWingOpened && !isLeftWingOpened
    }
    
    var state:WindowState {
        if isClosed { return .closed }
        if isOpened { return .opened }
        if isRightWingOpened { return .rightWingOpened }
        else { return .leftWingOpened }
    }
    
    init(number: Int) {
        self.number = number
    }
    
    func getVisitedBy(visitor: Visitor) {
        if visitor.interactsWithWindow(windowNumber: number) {
            switch visitor.type {
            case .first:
                isLeftWingOpened = true
            case .second:
                isRightWingOpened = true
            case .pair:
                isLeftWingOpened = false
                isRightWingOpened = true
            case .odd:
                isLeftWingOpened = true
                isRightWingOpened = false
            case .last:
                isRightWingOpened = !isRightWingOpened
            }
        }
    }
}
