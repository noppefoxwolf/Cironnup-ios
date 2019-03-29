//
//  GroupConfiguratorTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 12/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class GroupModuleConfiguratorTests: XCTestCase {

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
        let viewController = GroupViewControllerMock()
        let configurator = GroupModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "GroupViewController is nil after configuration")
        XCTAssertTrue(viewController.output is GroupPresenter, "output is not GroupPresenter")

        let presenter: GroupPresenter = viewController.output as! GroupPresenter
        XCTAssertNotNil(presenter.view, "view in GroupPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in GroupPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is GroupRouter, "router is not GroupRouter")

        let interactor: GroupInteractor = presenter.interactor as! GroupInteractor
        XCTAssertNotNil(interactor.output, "output in GroupInteractor is nil after configuration")
    }

    class GroupViewControllerMock: GroupViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
