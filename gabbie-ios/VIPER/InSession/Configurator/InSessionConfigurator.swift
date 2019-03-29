//
//  InSessionConfigurator.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class InSessionModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? InSessionViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: InSessionViewController) {

        let router = InSessionRouter()

        let presenter = InSessionPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = InSessionInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
