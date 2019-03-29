//
//  SettingsInitializer.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 28/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class SettingsModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var settingsViewController: SettingsViewController!

    override func awakeFromNib() {

        let configurator = SettingsModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: settingsViewController)
    }

}
