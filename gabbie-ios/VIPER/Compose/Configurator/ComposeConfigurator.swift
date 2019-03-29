//
//  ComposeConfigurator.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 14/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class ComposeModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ComposeViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ComposeViewController) {

        let router = ComposeRouter()

        let presenter = ComposePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ComposeInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
