class Castle {
    
    static let totalWindowsCount: Int = 64
    
    var windows:[Window] = []
    
    init() {
        resetCastle()
    }
    
    //Testing constructor(mainly)
    init(windows:[Window]) {
        guard windows.count == Castle.totalWindowsCount else { fatalError("Total windows count incorrect. Please modify totalWindowsCount before compilation") }
        self.windows = windows
    }
    
    func getVisitedBy(visitor: Visitor) {
        windows.forEach { $0.getVisitedBy(visitor: visitor) }
    }
    
    func getWindowsCurrentStateDescription() -> String {
        windows.map { $0.state.rawValue }.joined()
    }
    
    func getWinners(openWins: Bool) -> [Int] {
        
        if openWins {
            return windows.filter{ $0.isOpened }.map{ $0.number }
        } else {
            return windows.filter { window -> Bool in
                if window.isOpened {
                    guard let previousWindow = windows.first(where: { $0.number == window.previousNumber }) else { fatalError("Window has no previous window") }
                    guard let nextWindow = windows.first(where: { $0.number == window.nextNumber }) else { fatalError("Window has no next window") }
                    return nextWindow.isClosed && previousWindow.isClosed
                } else { return false }
            }.map{$0.number}
        }
        
    }
    
    func resetCastle() {
        var temporalWindows = [Window]()
        for value in 1...Castle.totalWindowsCount {
            temporalWindows.append(Window(number: value))
        }
        windows = temporalWindows
    }
}
