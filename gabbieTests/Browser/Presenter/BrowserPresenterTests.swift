//
//  BrowserPresenterTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 06/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class BrowserPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: BrowserInteractorInput {

    }

    class MockRouter: BrowserRouterInput {

    }

    class MockViewController: BrowserViewInput {

        func setupInitialState() {

        }
    }
}
