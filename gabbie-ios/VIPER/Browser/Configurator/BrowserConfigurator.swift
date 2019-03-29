//
//  BrowserConfigurator.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 06/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class BrowserModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? BrowserViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: BrowserViewController) {

        let router = BrowserRouter()

        let presenter = BrowserPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = BrowserInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
