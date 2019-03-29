//
//  ComposeInteractor.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 14/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit
import MediaPlayer
import Photos

class ComposeInteractor: ComposeInteractorInput {
  weak var output: ComposeInteractorOutput!
  private let maxSize: CGSize = .init(width: 1024, height: 1024)
  private var retrieverInstances: [String : ImageRetriever] = [:]
  
  func publish(_ body: String, attachmentIDs: [String], credential: Credential) {
    PostComposer.shared.publish(body, attachmentIDs: attachmentIDs, credential: credential)
  }
  
  func reply(to postID: Int, body: String, attachmentIDs: [String], credential: Credential) {
    PostComposer.shared.reply(to: postID, body: body, attachmentIDs: attachmentIDs, credential: credential)
  }
  
  func quote(to postID: Int, body: String, attachmentIDs: [String], credential: Credential) {
    PostComposer.shared.quote(to: postID, body: body, attachmentIDs: attachmentIDs, credential: credential)
  }
  
  func upload(with id: String, image: UIImage, credential: Credential) {
    PostComposer.shared.upload(image, credential: credential) { [weak self] (response) in
      self?.output.didUploaded(id, image: image, mediaAttachmentID: response.id)
    }
  }
  
  func retrieve(_ assets: [PHAsset]) {
    let key = UUID().uuidString
    let retriever = ImageRetriever(assets: assets)
    retrieverInstances[key] = retriever
    retriever.process(maxSize: maxSize, completion: { [weak self] (results) in
      for result in results {
        switch result {
        case .image(let image):
          self?.compless(image)
        case .failed: break
        }
      }
      self?.retrieverInstances.removeValue(forKey: key)
    })
  }
  
  func compless(_ image: UIImage) {
    // resize session
    guard let resized = image.resize(to: maxSize, alwaysShrink: true) else { return }
    
    // compress session
    var compression: CGFloat = 1.0
    let maxCompression: CGFloat = 0.1
    let maxFileSize = 4000 * 1024 * 1024 // 4MB
    
    var imageData = resized.jpegData(compressionQuality: compression)
    while (imageData?.count ?? 0) > maxFileSize && compression > maxCompression {
      compression -= 0.1
      imageData = resized.jpegData(compressionQuality: compression)
    }
    guard let data = imageData else { return }
    guard let resultImage = UIImage(data: data) else { return }
    output.didCompressed(resultImage)
  }
  
  func fetchNowplayingItem() {
    let player = MPMusicPlayerController.systemMusicPlayer
    guard let item = player.nowPlayingItem else { return }
    guard let title = item.title else { return }
    output.didFindNowplayingItem(title,
                                 artist: item.artist,
                                 album: item.albumTitle,
                                 artwork: item.artwork?.image(at: .init(width: 320, height: 320)))
  }
}
