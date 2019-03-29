//
//  TipJarConfiguratorTests.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import XCTest

class TipJarModuleConfiguratorTests: XCTestCase {

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
        let viewController = TipJarViewControllerMock()
        let configurator = TipJarModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "TipJarViewController is nil after configuration")
        XCTAssertTrue(viewController.output is TipJarPresenter, "output is not TipJarPresenter")

        let presenter: TipJarPresenter = viewController.output as! TipJarPresenter
        XCTAssertNotNil(presenter.view, "view in TipJarPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in TipJarPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is TipJarRouter, "router is not TipJarRouter")

        let interactor: TipJarInteractor = presenter.interactor as! TipJarInteractor
        XCTAssertNotNil(interactor.output, "output in TipJarInteractor is nil after configuration")
    }

    class TipJarViewControllerMock: TipJarViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
