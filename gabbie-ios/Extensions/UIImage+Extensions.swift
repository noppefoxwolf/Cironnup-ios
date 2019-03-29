//
//  UIImage+Extensions.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/14.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

extension UIImage {
  func resize(to size: CGSize, alwaysShrink: Bool = false) -> UIImage? {
    let widthRatio = size.width / self.size.width
    let heightRatio = size.height / self.size.height
    if alwaysShrink && widthRatio > 1.0 && heightRatio > 1.0 {
      return self
    }
    
    let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
    
    let resizedSize = CGSize(width: self.size.width * ratio, height: self.size.height * ratio)
    
    UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
    draw(in: CGRect(origin: .zero, size: resizedSize))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return resizedImage
  }
  
  func tint(tintColor: UIColor) -> UIImage {
    
    return modifiedImage { context, rect in
      // draw black background - workaround to preserve color of partially transparent pixels
      context.setBlendMode(.normal)
      UIColor.black.setFill()
      context.fill(rect)
      
      // draw original image
      context.setBlendMode(.normal)
      context.draw(self.cgImage!, in: rect)
      
      // tint image (loosing alpha) - the luminosity of the original image is preserved
      context.setBlendMode(.color)
      tintColor.setFill()
      context.fill(rect)
      
      // mask by alpha values of original image
      context.setBlendMode(.destinationIn)
      context.draw(self.cgImage!, in: rect)
    }
  }
  
  private func modifiedImage( draw: (CGContext, CGRect) -> ()) -> UIImage {
    
    // using scale correctly preserves retina images
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    let context: CGContext! = UIGraphicsGetCurrentContext()
    assert(context != nil)
    
    // correctly rotate image
    context.translateBy(x: 0, y: size.height)
    context.scaleBy(x: 1.0, y: -1.0)
    
    let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
    
    draw(context, rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}

