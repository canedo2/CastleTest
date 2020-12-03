//
//  CastleTestTests.swift
//  CastleTestTests
//
//  Created by Diego Manuel Molina Canedo on 3/12/20.
//

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
        XCTAssertTrue(castle.windows.count == 64)
        
        guard let firstWindow = castle.windows.first else {
            XCTFail()
            return
        }
        XCTAssertTrue(firstWindow.windowNumber == 1)
        XCTAssertTrue(firstWindow.isWindowClosed)
        XCTAssertTrue(!firstWindow.isWindowOpened)
        XCTAssertTrue(!firstWindow.isRightWingOpened)
        XCTAssertTrue(!firstWindow.isLeftWingOpened)
        
        guard let lastWindow = castle.windows.last else {
            XCTFail()
            return
        }
        XCTAssertTrue(lastWindow.windowNumber == 64)
        XCTAssertTrue(lastWindow.isWindowClosed)
        XCTAssertTrue(!lastWindow.isWindowOpened)
        XCTAssertTrue(!lastWindow.isRightWingOpened)
        XCTAssertTrue(!lastWindow.isLeftWingOpened)
    }
    
    func testWindowsState() throws {
        castle.windows.forEach { XCTAssertTrue($0.state == .closed) }
        
        let window1 = Window(number: 1)
        XCTAssert(window1.isWindowClosed)
        XCTAssert(!window1.isWindowOpened)
        XCTAssertTrue(!window1.isLeftWingOpened)
        XCTAssertTrue(!window1.isRightWingOpened)
        XCTAssertTrue(window1.state == .closed)
        
        let window2 = Window(number: 2)
        window2.isLeftWingOpened = true
        XCTAssertTrue(!window2.isWindowClosed)
        XCTAssertTrue(!window2.isWindowOpened)
        XCTAssertTrue(!window2.isRightWingOpened)
        XCTAssertTrue(window2.isLeftWingOpened)
        XCTAssertTrue(window2.state == .leftWingOpened)
        
        let window3 = Window(number: 3)
        window3.isRightWingOpened = true
        XCTAssertTrue(!window3.isWindowClosed)
        XCTAssertTrue(!window3.isWindowOpened)
        XCTAssertTrue(window3.isRightWingOpened)
        XCTAssertTrue(!window3.isLeftWingOpened)
        XCTAssertTrue(window3.state == .rightWingOpened)
        
        let window4 = Window(number: 4)
        window4.isRightWingOpened = true
        window4.isLeftWingOpened = true
        XCTAssertTrue(!window4.isWindowClosed)
        XCTAssertTrue(window4.isWindowOpened)
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
        let expectedDescription = "IACAIIIACAIIIACAIIIACAIIIACAIIIACAIIIACAIIIACAIIIACAIIIACAIIIACA"
        XCTAssertTrue(description == expectedDescription)
    }

}
