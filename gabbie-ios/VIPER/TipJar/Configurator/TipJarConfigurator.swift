//
//  TipJarConfigurator.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class TipJarModuleConfigurator {
  
  func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
    
    if let viewController = viewInput as? TipJarViewController {
      configure(viewController: viewController)
    }
  }
  
  private func configure(viewController: TipJarViewController) {
    
    let router = TipJarRouter()
    
    let presenter = TipJarPresenter()
    presenter.view = viewController
    presenter.router = router

    #if DEBUG
    let interactor = StubTipJarInteractor()
    #else
    let interactor = TipJarInteractor()
    #endif
    interactor.output = presenter
    
    presenter.interactor = interactor
    viewController.output = presenter
  }
  
}

