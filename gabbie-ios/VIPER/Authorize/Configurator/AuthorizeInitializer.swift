//
//  AuthorizeInitializer.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class AuthorizeModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var authorizeViewController: AuthorizeViewController!

    override func awakeFromNib() {
        let configurator = AuthorizeModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: authorizeViewController)
    }

}
