//
//  ComposePresenter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 14/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit
import UIKit
import MediaPlayer
import CironnupKit
import Photos

class ComposePresenter: ComposeModuleInput, ComposeViewOutput, ComposeInteractorOutput {
  weak var view: ComposeViewInput!
  var interactor: ComposeInteractorInput!
  var router: ComposeRouterInput!
  
  private lazy var account: Account = { preconditionFailure() }()
  
  func viewIsReady() {
    
  }
  
  func setupAccount(_ account: Account) {
    self.account = account
  }
  
  func tappedCloseButton() {
    router.dismiss(view: view)
  }
  
  func tappedComposeButton(current text: String, attachmentIDs: [String], replyMode: ReplyMode) {
    switch replyMode {
    case .normal:
      interactor.publish(text, attachmentIDs: attachmentIDs, credential: account.clientSource.credential)
    case .quote(postID: let id, body: _):
      interactor.quote(to: id, body: text, attachmentIDs: attachmentIDs, credential: account.clientSource.credential)
    case .reply(postID: let id, username: _, body: _):
      interactor.reply(to: id, body: text, attachmentIDs: attachmentIDs, credential: account.clientSource.credential)
    }
    router.dismiss(view: view)
  }
  
  func textDidChanged(text: String) {
    view.configure(sendButton: text.count > 0)
  }
  
  func tappedCameraButton() {
    view.presentMediaSourcePicker()
  }
  
  func tappedRemoveAttachmentButton(at index: Int) {
    view.removeAttachment(at: index)
  }
  
  func didSelectAssets(_ assets: [PHAsset]) {
    interactor.retrieve(assets)
  }
  
  func didSelectImage(_ image: UIImage) {
    interactor.compless(image)
  }
  
  func didCompressed(_ image: UIImage) {
    let attachment = LocalAttachment(id: UUID().uuidString, image: image)
    interactor.upload(with: attachment.id, image: image, credential: account.clientSource.credential)
    view.append(attachment: attachment)
  }
  
  func didUploaded(_ id: String, image: UIImage, mediaAttachmentID: String) {
    let attachment = LocalAttachment(id: id, attachmentID: mediaAttachmentID, image: image)
    view.update(attachment: attachment)
  }
  
  func tappedNowplayingButton() {
    interactor.fetchNowplayingItem()
  }
  
  func didFindNowplayingItem(_ title: String, artist: String?, album: String?, artwork: UIImage?) {
    let body = [title, artist, album].compactMap({ $0 }).joined(separator: " - ") + " #nowplaying"
    view.configure(body: body)
    if let image = artwork {
      let attachment = LocalAttachment(id: UUID().uuidString, image: image)
      interactor.upload(with: attachment.id, image: image, credential: account.clientSource.credential)
      view.append(attachment: attachment)
    }
  }
}

