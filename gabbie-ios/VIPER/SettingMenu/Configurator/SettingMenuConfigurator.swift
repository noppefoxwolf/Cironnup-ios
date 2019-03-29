//
//  SettingMenuConfigurator.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class SettingMenuModuleConfigurator<T: Equatable> {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SettingMenuViewController<T> {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SettingMenuViewController<T>) {

        let router = SettingMenuRouter()

        let presenter = SettingMenuPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SettingMenuInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
