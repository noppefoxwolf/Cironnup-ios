//
//  InSessionConfiguratorTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class InSessionModuleConfiguratorTests: XCTestCase {

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
        let viewController = InSessionViewControllerMock()
        let configurator = InSessionModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "InSessionViewController is nil after configuration")
        XCTAssertTrue(viewController.output is InSessionPresenter, "output is not InSessionPresenter")

        let presenter: InSessionPresenter = viewController.output as! InSessionPresenter
        XCTAssertNotNil(presenter.view, "view in InSessionPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in InSessionPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is InSessionRouter, "router is not InSessionRouter")

        let interactor: InSessionInteractor = presenter.interactor as! InSessionInteractor
        XCTAssertNotNil(interactor.output, "output in InSessionInteractor is nil after configuration")
    }

    class InSessionViewControllerMock: InSessionViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
