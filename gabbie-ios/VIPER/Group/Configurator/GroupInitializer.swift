//
//  GroupInitializer.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 12/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class GroupModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var groupViewController: GroupViewController!

    override func awakeFromNib() {

        let configurator = GroupModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: groupViewController)
    }

}
