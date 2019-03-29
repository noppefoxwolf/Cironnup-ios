//
//  ComposeConfiguratorTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 14/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class ComposeModuleConfiguratorTests: XCTestCase {

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
        let viewController = ComposeViewControllerMock()
        let configurator = ComposeModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "ComposeViewController is nil after configuration")
        XCTAssertTrue(viewController.output is ComposePresenter, "output is not ComposePresenter")

        let presenter: ComposePresenter = viewController.output as! ComposePresenter
        XCTAssertNotNil(presenter.view, "view in ComposePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in ComposePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is ComposeRouter, "router is not ComposeRouter")

        let interactor: ComposeInteractor = presenter.interactor as! ComposeInteractor
        XCTAssertNotNil(interactor.output, "output in ComposeInteractor is nil after configuration")
    }

    class ComposeViewControllerMock: ComposeViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
