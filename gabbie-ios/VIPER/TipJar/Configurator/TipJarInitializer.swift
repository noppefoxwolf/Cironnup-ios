//
//  TipJarInitializer.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class TipJarModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var tipjarViewController: TipJarViewController!

    override func awakeFromNib() {

        let configurator = TipJarModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: tipjarViewController)
    }

}
