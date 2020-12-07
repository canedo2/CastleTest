import XCTest
@testable import CastleTest

class CastleTestTests: XCTestCase {

    var castle:Castle = Castle()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        castle = Castle()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCastleIsCorrectlyCreated() throws {
        XCTAssertTrue(castle.windows.count == Castle.totalWindowsCount)
        
        guard let firstWindow = castle.windows.first else {
            XCTFail()
            return
        }
        XCTAssertTrue(firstWindow.number == 1)
        XCTAssertTrue(firstWindow.isClosed)
        XCTAssertTrue(!firstWindow.isOpened)
        XCTAssertTrue(!firstWindow.isRightWingOpened)
        XCTAssertTrue(!firstWindow.isLeftWingOpened)
        
        guard let lastWindow = castle.windows.last else {
            XCTFail()
            return
        }
        XCTAssertTrue(lastWindow.number == Castle.totalWindowsCount)
        XCTAssertTrue(lastWindow.isClosed)
        XCTAssertTrue(!lastWindow.isOpened)
        XCTAssertTrue(!lastWindow.isRightWingOpened)
        XCTAssertTrue(!lastWindow.isLeftWingOpened)
    }
    
    func testWindowsState() throws {
        castle.windows.forEach { XCTAssertTrue($0.state == .closed) }
        
        let window1 = Window(number: 1)
        XCTAssert(window1.isClosed)
        XCTAssert(!window1.isOpened)
        XCTAssertTrue(!window1.isLeftWingOpened)
        XCTAssertTrue(!window1.isRightWingOpened)
        XCTAssertTrue(window1.state == .closed)
        
        let window2 = Window(number: 2)
        window2.isLeftWingOpened = true
        XCTAssertTrue(!window2.isClosed)
        XCTAssertTrue(!window2.isOpened)
        XCTAssertTrue(!window2.isRightWingOpened)
        XCTAssertTrue(window2.isLeftWingOpened)
        XCTAssertTrue(window2.state == .leftWingOpened)
        
        let window3 = Window(number: 3)
        window3.isRightWingOpened = true
        XCTAssertTrue(!window3.isClosed)
        XCTAssertTrue(!window3.isOpened)
        XCTAssertTrue(window3.isRightWingOpened)
        XCTAssertTrue(!window3.isLeftWingOpened)
        XCTAssertTrue(window3.state == .rightWingOpened)
        
        let window4 = Window(number: 4)
        window4.isRightWingOpened = true
        window4.isLeftWingOpened = true
        XCTAssertTrue(!window4.isClosed)
        XCTAssertTrue(window4.isOpened)
        XCTAssertTrue(window4.isRightWingOpened)
        XCTAssertTrue(window4.isLeftWingOpened)
        XCTAssertTrue(window4.state == .opened)
        
    }
    
    func testCastleWindowsAfterVisitor1() throws {
        let visitor1 = Visitor(braceletNumber: 1)
        castle.getVisitedBy(visitor: visitor1)
        
        let description = castle.getWindowsCurrentStateDescription()
        let expectedDescription = "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
        XCTAssertTrue(description == expectedDescription)
    }
    
    func testCastleWindowsAfterVisitor2() throws {
        let visitor2 = Visitor(braceletNumber: 2)
        castle.getVisitedBy(visitor: visitor2)
        
        let description = castle.getWindowsCurrentStateDescription()
        let expectedDescription = "CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCD"
        XCTAssertTrue(description == expectedDescription)
    }
    
    func testCastleWindowsAfterVisitors1And2() throws {
        let visitor1 = Visitor(braceletNumber: 1)
        let visitor2 = Visitor(braceletNumber: 2)
        castle.getVisitedBy(visitor: visitor1)
        castle.getVisitedBy(visitor: visitor2)
        
        let description = castle.getWindowsCurrentStateDescription()
        let expectedDescription = "IAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIAIA"
        XCTAssertTrue(description == expectedDescription)
    }
    
    func testCastleWindowsAfterVisitors1_2_3() throws {
        let visitor1 = Visitor(braceletNumber: 1)
        let visitor2 = Visitor(braceletNumber: 2)
        let visitor3 = Visitor(braceletNumber: 3)
        castle.getVisitedBy(visitor: visitor1)
        castle.getVisitedBy(visitor: visitor2)
        castle.getVisitedBy(visitor: visitor3)
        
        let description = castle.getWindowsCurrentStateDescription()
        let expectedDescription = "IAIAIIIAIAIIIAIAIIIAIAIIIAIAIIIAIAIIIAIAIIIAIAIIIAIAIIIAIAIIIAIA"
        XCTAssertTrue(description == expectedDescription)
    }
    
    func testCastleWindowsAfterVisitors1_2_3_4() {
        let visitor1 = Visitor(braceletNumber: 1)
        let visitor2 = Visitor(braceletNumber: 2)
        let visitor3 = Visitor(braceletNumber: 3)
        let visitor4 = Visitor(braceletNumber: 4)
        
        castle.getVisitedBy(visitor: visitor1)
        castle.getVisitedBy(visitor: visitor2)
        castle.getVisitedBy(visitor: visitor3)
        castle.getVisitedBy(visitor: visitor4)
        
        let description = castle.getWindowsCurrentStateDescription()
        let expectedDescription = "IAIDIIIDIAIDIAIDIIIDIAIDIAIDIIIDIAIDIAIDIIIDIAIDIAIDIIIDIAIDIAID"
        XCTAssertTrue(description == expectedDescription)
    }
    
    func testCastleWindowsAfterVisitor61() {
        let visitor61 = Visitor(braceletNumber: 61)
        castle.getVisitedBy(visitor: visitor61)
        
        let description = castle.getWindowsCurrentStateDescription()
        let expectedDescription = "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCICCC"
        XCTAssertTrue(description == expectedDescription)
    }
    
    func testCastleWindowsAfterLastVisitor_twice() {
        let lastVisitor = Visitor(braceletNumber: Castle.totalWindowsCount)
        castle.getVisitedBy(visitor: lastVisitor)
        
        let description = castle.getWindowsCurrentStateDescription()
        let expectedDescription = "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD"
        XCTAssertTrue(description == expectedDescription)
        
        castle.getVisitedBy(visitor: lastVisitor)
        
        let description2 = castle.getWindowsCurrentStateDescription()
        let expectedDescription2 = "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC"
        XCTAssertTrue(description2 == expectedDescription2)
    }
    
    func testCastleWindowsAfterAllVisitors() {
        var visitors = [Visitor]()
        for braceletNumber in 1...Castle.totalWindowsCount {
            visitors.append(Visitor(braceletNumber: braceletNumber))
        }
        visitors.forEach { castle.getVisitedBy(visitor: $0) }
        let description = castle.getWindowsCurrentStateDescription()
        let expectedDescription = "IAIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIDIC"
        XCTAssertTrue(description == expectedDescription)
    }
    
    func testCastleGetWinners() {
        var windows = [Window]()
        var windows2 = [Window]()
        var windows3 = [Window]()
        for number in 1...Castle.totalWindowsCount {
            let window = Window(number: number)
            let condition1 = number % 2 == 0 //Results in a CACACACACACACA...
            window.isLeftWingOpened = condition1
            window.isRightWingOpened = condition1
            windows.append(window)
            
            let window2 = Window(number: number)
            let condition2 = number > Castle.totalWindowsCount/2 //Results in CCCCCCCC...AAAAAA...A
            window2.isLeftWingOpened = condition2
            window2.isRightWingOpened = condition2
            windows2.append(window2)
            
            let window3 = Window(number: number)
            let condition3 = number == 1 || number == 15 || number == 16 // Results in ACCCCCCCCCCCCCAACCC...
            window3.isLeftWingOpened = condition3
            window3.isRightWingOpened = condition3
            windows3.append(window3)
        }
        
        castle = Castle(windows: windows)
        XCTAssertTrue(castle.getWinners(openWins: false).count == windows.count/2)
        XCTAssertTrue(castle.getWinners(openWins: true).count == windows.count/2)
        
        castle = Castle(windows: windows2)
        XCTAssertTrue(castle.getWinners(openWins: false).count == 0)
        XCTAssertTrue(castle.getWinners(openWins: true).count == windows.count/2)
        
        castle = Castle(windows: windows3)
        XCTAssertTrue(castle.getWinners(openWins: false).count == 1)
        XCTAssertTrue(castle.getWinners(openWins: true).count == 3)
    }
    
    
    func testCastleWindowsWinners() {
        var visitors = [Visitor]()
        for braceletNumber in 1...Castle.totalWindowsCount {
            visitors.append(Visitor(braceletNumber: braceletNumber))
        }
        visitors.forEach {
            castle.getVisitedBy(visitor: $0)
            print(castle.getWindowsCurrentStateDescription())
        }
        XCTAssertTrue(castle.getWinners(openWins: false).count == 0)
        XCTAssertTrue(castle.getWinners(openWins: true).count == 1)
    }

}
