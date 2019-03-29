//
//  AuthorizeConfigurator.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class AuthorizeModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? AuthorizeViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: AuthorizeViewController) {

        let router = AuthorizeRouter()

        let presenter = AuthorizePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = AuthorizeInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
