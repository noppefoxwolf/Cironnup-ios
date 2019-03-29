//
//  BrowserInitializer.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 06/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class BrowserModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var browserViewController: BrowserViewController!

    override func awakeFromNib() {

        let configurator = BrowserModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: browserViewController)
    }

}
