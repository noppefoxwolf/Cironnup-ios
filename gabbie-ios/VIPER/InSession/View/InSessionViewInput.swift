//
//  InSessionViewInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 13/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit

protocol InSessionViewInput: class {

    /**
        @author noppefoxwolf
        Setup initial state of the view
    */

    func setupInitialState(credential: Credential)
}
