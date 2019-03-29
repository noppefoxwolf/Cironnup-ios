//
//  ProfileConfigurator.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 23/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class ProfileModuleConfigurator {
  
  func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
    
    if let viewController = viewInput as? ProfileViewController {
      configure(viewController: viewController)
    }
  }
  
  private func configure(viewController: ProfileViewController) {
    
    let router = ProfileRouter()
    
    let presenter = ProfilePresenter()
    presenter.view = viewController
    presenter.router = router
    
    let interactor = ProfileInteractor()
    interactor.output = presenter
    
    presenter.interactor = interactor
    viewController.output = presenter
  }
  
}

