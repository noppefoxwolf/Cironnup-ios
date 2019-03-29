//
//  SettingMenuPresenter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

class SettingMenuPresenter: SettingMenuModuleInput, SettingMenuViewOutput, SettingMenuInteractorOutput {

    weak var view: SettingMenuViewInput!
    var interactor: SettingMenuInteractorInput!
    var router: SettingMenuRouterInput!

    func viewIsReady() {

    }
}
