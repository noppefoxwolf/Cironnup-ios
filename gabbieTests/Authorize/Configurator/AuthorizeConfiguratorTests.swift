//
//  AuthorizeConfiguratorTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class AuthorizeModuleConfiguratorTests: XCTestCase {

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
        let viewController = AuthorizeViewControllerMock()
        let configurator = AuthorizeModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "AuthorizeViewController is nil after configuration")
        XCTAssertTrue(viewController.output is AuthorizePresenter, "output is not AuthorizePresenter")

        let presenter: AuthorizePresenter = viewController.output as! AuthorizePresenter
        XCTAssertNotNil(presenter.view, "view in AuthorizePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in AuthorizePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is AuthorizeRouter, "router is not AuthorizeRouter")

        let interactor: AuthorizeInteractor = presenter.interactor as! AuthorizeInteractor
        XCTAssertNotNil(interactor.output, "output in AuthorizeInteractor is nil after configuration")
    }

    class AuthorizeViewControllerMock: AuthorizeViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
