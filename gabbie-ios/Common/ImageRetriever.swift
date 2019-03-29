//
//  ImageRetriever.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/27.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Photos

final class ImageRetriever {
  enum Result {
    case image(UIImage)
    case failed
  }
  
  private let assets: [PHAsset]
  private var results: [Result] = []
  private var completion: (([Result]) -> Void)? = nil
  init(assets: [PHAsset]) {
    self.assets = assets
  }
  
  func process(maxSize: CGSize, completion: (([Result]) -> Void)?) {
    results = []
    self.completion = completion
    let im = PHImageManager.default()
    
    for asset in assets {
      let options = PHImageRequestOptions()
      options.deliveryMode = .highQualityFormat
      im.requestImage(for: asset, targetSize: maxSize, contentMode: .aspectFit, options: options)
      { [weak self] (image, info) in
        if let image = image {
          self?.results.append(.image(image))
        } else {
          self?.results.append(.failed)
        }
        self?.checkCompletion()
      }
    }
  }
  
  private func checkCompletion() {
    if results.count == assets.count {
      completion?(results)
    }
  }
}
