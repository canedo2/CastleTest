enum VisitorType {
    case first
    case second
    case pair
    case odd
    case last
}

struct Visitor {
    
    let braceletNumber: Int
    
    var type: VisitorType {
        if braceletNumber == 1 { return .first }
        else if braceletNumber == 2 { return .second }
        else if braceletNumber == Castle.totalWindowsCount { return .last }
        else if braceletNumber % 2 == 0 { return .pair}
        else /*if braceletNumber % 2 == 1*/ { return .odd}
    }
    
    func interactsWithWindow(windowNumber: Int) -> Bool {
        return windowNumber % braceletNumber == 0
    }
}
