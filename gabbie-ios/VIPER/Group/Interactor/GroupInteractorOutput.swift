//
//  GroupInteractorOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 12/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import GabKit

protocol GroupInteractorOutput: class {
  func didReceived(_ groups: [Group])
  func didReceived(_ error: Error)
}
