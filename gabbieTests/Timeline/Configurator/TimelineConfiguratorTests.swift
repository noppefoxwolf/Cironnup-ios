//
//  TimelineConfiguratorTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class TimelineModuleConfiguratorTests: XCTestCase {

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
        let viewController = TimelineViewControllerMock()
        let configurator = TimelineModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "TimelineViewController is nil after configuration")
        XCTAssertTrue(viewController.output is TimelinePresenter, "output is not TimelinePresenter")

        let presenter: TimelinePresenter = viewController.output as! TimelinePresenter
        XCTAssertNotNil(presenter.view, "view in TimelinePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in TimelinePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is TimelineRouter, "router is not TimelineRouter")

        let interactor: TimelineInteractor = presenter.interactor as! TimelineInteractor
        XCTAssertNotNil(interactor.output, "output in TimelineInteractor is nil after configuration")
    }

    class TimelineViewControllerMock: TimelineViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
