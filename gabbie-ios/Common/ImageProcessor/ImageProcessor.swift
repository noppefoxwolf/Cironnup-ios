//
//  ImageProcessor.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/11/13.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit
import CoreImage
import PINRemoteImage

struct ImageProcessor {
  static var blur: PINRemoteImageManagerImageProcessor = { (result, cost) -> UIImage? in
    guard let image = result.image else { return nil }
    guard let ciImage = CIImage(image: image) else { return nil }
    guard let filter = CIFilter(name: "CIGaussianBlur") else { return nil }
    filter.setValue(ciImage, forKey: kCIInputImageKey)
    filter.setValue(20, forKey: kCIInputRadiusKey)
    guard let outputCIImage = filter.outputImage else { return nil }
    return UIImage(ciImage: outputCIImage)
  }
}
