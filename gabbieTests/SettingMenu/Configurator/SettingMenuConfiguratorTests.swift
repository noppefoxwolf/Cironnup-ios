//
//  SettingMenuConfiguratorTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class SettingMenuModuleConfiguratorTests: XCTestCase {

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
        let viewController = SettingMenuViewControllerMock()
        let configurator = SettingMenuModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SettingMenuViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SettingMenuPresenter, "output is not SettingMenuPresenter")

        let presenter: SettingMenuPresenter = viewController.output as! SettingMenuPresenter
        XCTAssertNotNil(presenter.view, "view in SettingMenuPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SettingMenuPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SettingMenuRouter, "router is not SettingMenuRouter")

        let interactor: SettingMenuInteractor = presenter.interactor as! SettingMenuInteractor
        XCTAssertNotNil(interactor.output, "output in SettingMenuInteractor is nil after configuration")
    }

    class SettingMenuViewControllerMock: SettingMenuViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
