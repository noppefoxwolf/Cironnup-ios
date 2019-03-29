//
//  BrowserConfiguratorTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 06/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class BrowserModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = BrowserViewControllerMock()
        let configurator = BrowserModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "BrowserViewController is nil after configuration")
        XCTAssertTrue(viewController.output is BrowserPresenter, "output is not BrowserPresenter")

        let presenter: BrowserPresenter = viewController.output as! BrowserPresenter
        XCTAssertNotNil(presenter.view, "view in BrowserPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in BrowserPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is BrowserRouter, "router is not BrowserRouter")

        let interactor: BrowserInteractor = presenter.interactor as! BrowserInteractor
        XCTAssertNotNil(interactor.output, "output in BrowserInteractor is nil after configuration")
    }

    class BrowserViewControllerMock: BrowserViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
