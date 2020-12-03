enum WindowState:String {
    case closed = "C"
    case opened = "A"
    case leftWingOpened = "I"
    case rightWingOpened = "D"
}

class Window {
    let windowNumber: Int
    var isRightWingOpened: Bool = false
    var isLeftWingOpened: Bool = false
    
    var isWindowOpened: Bool {
        return isRightWingOpened && isLeftWingOpened
    }
    var isWindowClosed: Bool {
        return !isRightWingOpened && !isLeftWingOpened
    }
    
    var state:WindowState {
        if isWindowClosed { return .closed }
        if isWindowOpened { return .opened }
        if isRightWingOpened { return .rightWingOpened }
        else { return .leftWingOpened }
    }
    
    init(number: Int) {
        self.windowNumber = number
    }
    
    func getVisitedBy(visitor: Visitor) {
        if visitor.interactsWithWindow(windowNumber: windowNumber) {
            if visitor.isOpenLeftCloseRightVisitor {
                isLeftWingOpened = true
                isRightWingOpened = false
            } else {
                isRightWingOpened = true
                isLeftWingOpened = false
            }
        }
    }
}
