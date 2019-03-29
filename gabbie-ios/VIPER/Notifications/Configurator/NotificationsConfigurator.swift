//
//  NotificationsConfigurator.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 18/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class NotificationsModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? NotificationsViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: NotificationsViewController) {

        let router = NotificationsRouter()

        let presenter = NotificationsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = NotificationsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
