struct Visitor {
    let braceletNumber: Int

    var isOpenLeftCloseRightVisitor: Bool {
        braceletNumber % 2 == 1
    }
    
    func interactsWithWindow(windowNumber: Int) -> Bool {
        return windowNumber % braceletNumber == 0
        
    }
}
