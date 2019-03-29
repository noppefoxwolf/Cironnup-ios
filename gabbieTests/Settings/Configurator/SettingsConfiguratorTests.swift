//
//  SettingsConfiguratorTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 28/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class SettingsModuleConfiguratorTests: XCTestCase {

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
        let viewController = SettingsViewControllerMock()
        let configurator = SettingsModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SettingsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SettingsPresenter, "output is not SettingsPresenter")

        let presenter: SettingsPresenter = viewController.output as! SettingsPresenter
        XCTAssertNotNil(presenter.view, "view in SettingsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SettingsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SettingsRouter, "router is not SettingsRouter")

        let interactor: SettingsInteractor = presenter.interactor as! SettingsInteractor
        XCTAssertNotNil(interactor.output, "output in SettingsInteractor is nil after configuration")
    }

    class SettingsViewControllerMock: SettingsViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
