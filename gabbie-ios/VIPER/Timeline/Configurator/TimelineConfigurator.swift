//
//  TimelineConfigurator.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class TimelineModuleConfigurator {
  
  func configureModuleForViewInput<UIViewController>(viewInput: UIViewController,
                                                     interactor: TimelineInteractable) {
    
    if let viewController = viewInput as? TimelineViewController {
      configure(viewController: viewController, interactor: interactor)
    }
  }
  
  private func configure(viewController: TimelineViewController,
                         interactor: TimelineInteractable) {
    
    let router = TimelineRouter()
    
    let presenter = TimelinePresenter()
    presenter.view = viewController
    presenter.router = router
    
    var interactor = interactor
    interactor.output = presenter
    
    presenter.interactor = interactor
    viewController.output = presenter
  }
  
}

