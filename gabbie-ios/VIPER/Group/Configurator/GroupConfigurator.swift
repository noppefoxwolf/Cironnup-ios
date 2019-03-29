//
//  GroupConfigurator.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 12/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class GroupModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? GroupViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: GroupViewController) {

        let router = GroupRouter()

        let presenter = GroupPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = GroupInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
