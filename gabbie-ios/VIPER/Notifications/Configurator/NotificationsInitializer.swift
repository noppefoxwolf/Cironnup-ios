//
//  NotificationsInitializer.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 18/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class NotificationsModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var notificationsViewController: NotificationsViewController!

    override func awakeFromNib() {

        let configurator = NotificationsModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: notificationsViewController)
    }

}
