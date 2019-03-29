//
//  NotificationsConfiguratorTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 18/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class NotificationsModuleConfiguratorTests: XCTestCase {

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
        let viewController = NotificationsViewControllerMock()
        let configurator = NotificationsModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "NotificationsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is NotificationsPresenter, "output is not NotificationsPresenter")

        let presenter: NotificationsPresenter = viewController.output as! NotificationsPresenter
        XCTAssertNotNil(presenter.view, "view in NotificationsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in NotificationsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is NotificationsRouter, "router is not NotificationsRouter")

        let interactor: NotificationsInteractor = presenter.interactor as! NotificationsInteractor
        XCTAssertNotNil(interactor.output, "output in NotificationsInteractor is nil after configuration")
    }

    class NotificationsViewControllerMock: NotificationsViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
