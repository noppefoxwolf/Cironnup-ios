//
//  SettingsConfigurator.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 28/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class SettingsModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SettingsViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SettingsViewController) {

        let router = SettingsRouter()

        let presenter = SettingsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SettingsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
