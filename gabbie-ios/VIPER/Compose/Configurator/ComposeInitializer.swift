//
//  ComposeInitializer.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 14/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class ComposeModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var composeViewController: ComposeViewController!

    override func awakeFromNib() {

        let configurator = ComposeModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: composeViewController)
    }

}
