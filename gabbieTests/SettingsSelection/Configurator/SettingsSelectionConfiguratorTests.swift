//
//  SettingsSelectionConfiguratorTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class SettingsSelectionModuleConfiguratorTests: XCTestCase {

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
        let viewController = SettingsSelectionViewControllerMock()
        let configurator = SettingsSelectionModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "SettingsSelectionViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SettingsSelectionPresenter, "output is not SettingsSelectionPresenter")

        let presenter: SettingsSelectionPresenter = viewController.output as! SettingsSelectionPresenter
        XCTAssertNotNil(presenter.view, "view in SettingsSelectionPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SettingsSelectionPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SettingsSelectionRouter, "router is not SettingsSelectionRouter")

        let interactor: SettingsSelectionInteractor = presenter.interactor as! SettingsSelectionInteractor
        XCTAssertNotNil(interactor.output, "output in SettingsSelectionInteractor is nil after configuration")
    }

    class SettingsSelectionViewControllerMock: SettingsSelectionViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
