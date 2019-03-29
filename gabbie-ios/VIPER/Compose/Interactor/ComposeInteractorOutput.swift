//
//  ComposeInteractorOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 14/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import UIKit

protocol ComposeInteractorOutput: class {
  func didCompressed(_ image: UIImage)
  func didUploaded(_ id: String, image: UIImage, mediaAttachmentID: String)
  func didFindNowplayingItem(_ title: String, artist: String?, album: String?, artwork: UIImage?)
}
