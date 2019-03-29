//
//  InSessionInitializer.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class InSessionModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var insessionViewController: InSessionViewController!

    override func awakeFromNib() {

        let configurator = InSessionModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: insessionViewController)
    }

}
