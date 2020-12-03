class Castle {
    let windows:[Window]
    
    init() {
        var temporalWindows = [Window]()
        for value in 1...64 {
            temporalWindows.append(Window(number: value))
        }
        windows = temporalWindows
    }
    
    func getVisitedBy(visitor: Visitor) {
        windows.forEach { $0.getVisitedBy(visitor: visitor) }
    }
    
    func getWindowsCurrentStateDescription() -> String {
        windows.map { $0.state.rawValue }.joined()
    }
}
