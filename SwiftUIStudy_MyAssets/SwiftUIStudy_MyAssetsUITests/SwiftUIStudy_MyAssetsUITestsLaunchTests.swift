//
//  SwiftUIStudy_MyAssetsUITestsLaunchTests.swift
//  SwiftUIStudy_MyAssetsUITests
//
//  Created by 이준혁 on 2022/09/27.
//

import XCTest

final class SwiftUIStudy_MyAssetsUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
