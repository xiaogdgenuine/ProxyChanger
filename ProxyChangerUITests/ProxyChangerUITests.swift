//
//  ProxyChangerUITests.swift
//  ProxyChangerUITests
//
//  Created by foxtel on 2022/8/11.
//

import XCTest
import Foundation

class ProxyChangerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testChangeProxy() throws {
        let settingsApp = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        settingsApp.launch()
        settingsApp.tables.cells["WLAN"].tap()
        settingsApp.cells["WLAN"].children(matching: .other).element(boundBy: 0).tap()
        settingsApp.tables.element(boundBy: 1).cells.element(boundBy: 1).tap()
        settingsApp.staticTexts["Configure Proxy"].tap()
        settingsApp.staticTexts["Manual"].tap()
        let serverField = settingsApp.textFields["Server"]
        let portField = settingsApp.textFields["Port"]
        settingsApp.clearTextOnElement(serverField)
        
        let ipAddress = ProcessInfo.processInfo.environment["IP_Address"]!
        serverField.typeText(ipAddress)
        settingsApp.clearTextOnElement(portField)
        portField.typeText("8080")

        settingsApp.buttons["Save"].tap()
        settingsApp.tables.cells["WLAN"].tap()

        XCUIDevice.shared.press(.home)
    }

    func testTurnOffProxy() throws {
        let settingsApp = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        settingsApp.launch()
        settingsApp.tables.cells["WLAN"].tap()
        settingsApp.cells["WLAN"].children(matching: .other).element(boundBy: 0).tap()
        settingsApp.tables.element(boundBy: 1).cells.element(boundBy: 1).tap()
        settingsApp.staticTexts["Configure Proxy"].tap()
        settingsApp.staticTexts["Off"].tap()
        settingsApp.buttons["Save"].tap()
        settingsApp.tables.cells["WLAN"].tap()

        XCUIDevice.shared.press(.home)
    }

}

extension XCUIApplication {
    func clearTextOnElement(_ element: XCUIElement) {
        element.doubleTap()
        keys["delete"].tap()
    }
}
