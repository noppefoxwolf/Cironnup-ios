//
//  ComposeViewOutput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 14/10/2018.
//  Copyright © 2018 . All rights reserved.
//
import GabKit
import CironnupKit
import Photos

protocol ComposeViewOutput {
  
  /**
   @author noppefoxwolf
   Notify presenter that view is ready
   */
  
  func viewIsReady()
  func setupAccount(_ account: Account)
  func tappedCloseButton()
  func tappedComposeButton(current text: String, attachmentIDs: [String], replyMode: ReplyMode)
  func textDidChanged(text: String)
  func tappedCameraButton()
  func didSelectAssets(_ assets: [PHAsset])
  func didSelectImage(_ image: UIImage)
  func tappedRemoveAttachmentButton(at index: Int)
  func tappedNowplayingButton()
}

