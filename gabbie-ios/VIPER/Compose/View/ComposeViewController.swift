//
//  ComposeViewController.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 14/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import GabKit
import KeyboardLayoutGuide
import NohanaImagePicker
import Photos
import CironnupKit
import CironnupUI

enum ReplyMode {
  case normal
  case reply(postID: Int, username: String, body: String)
  case quote(postID: Int, body: String)
}

final class ComposeViewController: UIViewController, ComposeViewInput, AlwaysModalyPresenting {
  let navigationControllerType: UINavigationController.Type? = NavigationController.self
  var output: ComposeViewOutput!
  @IBOutlet private weak var composeContentView: ComposeContentView!
  @IBOutlet private weak var toolbar: UIToolbar!
  private var attachments: [LocalAttachment] = []
  private let maxAttachmentCount: Int = 4
  
  private lazy var mediaSourceButton: UIBarButtonItem = { preconditionFailure() }()
  private lazy var replyMode: ReplyMode = { preconditionFailure() }()
  
  static func make(reply mode: ReplyMode) -> ComposeViewController {
    let vc = StoryboardScene.Compose.initialScene.instantiate()
    vc.replyMode = mode
    return vc
  }
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
    composeContentView.layoutIfNeeded()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    composeContentView.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    composeContentView.resignFirstResponder()
  }
  
  // MARK: ComposeViewInput
  func setupInitialState(account: Account) {
    output.setupAccount(account)
    view.backgroundColor = ColorName.backgroundColor.color
    
    navigationItem: do {
      let close = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(tappedCloseButton))
      close.tintColor = ColorName.buttonTintColor.color
      navigationItem.leftBarButtonItem = close
      
      let compose = UIBarButtonItem(title: "Publish", style: .done, target: self, action: #selector(tappedComposeButton))
      compose.tintColor = ColorName.buttonTintColor.color
      navigationItem.rightBarButtonItem = compose
    }
    
    toolbar: do {
      toolbar.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true
      toolbar.barTintColor = ColorName.navigationTintColor.color
      
      mediaSourceButton = UIBarButtonItem.make(image: Asset.Icons.camera.image,
                                        target: self,
                                        action: #selector(tappedCameraButton))
      mediaSourceButton.tintColor = ColorName.buttonTintColor.color
      
      let np = UIBarButtonItem.make(image: Asset.Icons.nowplaying.image,
                                    target: self,
                                    action: #selector(tappedNowPlayingButton))
      np.tintColor = ColorName.buttonTintColor.color
      
      let other = UIBarButtonItem.make(image: Asset.Icons.Actions.more.image,
                                       target: self,
                                       action: #selector(tappedOtherButton))
      other.tintColor = ColorName.buttonTintColor.color
      
      let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
      let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      flexibleSpace.width = 4
      
      toolbar.setItems([mediaSourceButton, fixedSpace, np, flexibleSpace, other], animated: false)
    }
    
    composeContentView: do {
      composeContentView.placeholder = "What's happenning?".withFont(.systemFont(ofSize: 17)).withTextColor(.lightGray)
      composeContentView.configure(accountPicture: URL(string: account.pictureUrl))
      composeContentView.attachmentCollectionControlEventDelegate = self
      composeContentView.didChangedText = { [weak self] in
        guard let self = self else { return }
        self.output.textDidChanged(text: self.composeContentView.text)
      }
      switch replyMode {
      case .normal: break
      case .quote(postID: _, body: let body):
        composeContentView.quoteBody = body.withFont(.systemFont(ofSize: 12)).withTextColor(.lightGray)
      case .reply(postID: _, username: let username, body: let body):
        composeContentView.text = "@\(username) "
        composeContentView.replyToBody = body.withFont(.systemFont(ofSize: 12)).withTextColor(.lightGray)
      }
    }
  }
  
  @objc private func tappedCloseButton(_ sender: UIBarButtonItem) {
    output.tappedCloseButton()
  }
  
  @objc private func tappedComposeButton(_ sender: UIBarButtonItem) {
    output.tappedComposeButton(current: composeContentView.text, attachmentIDs: attachments.compactMap({ $0.attachmentID }), replyMode: replyMode)
  }
  
  @objc private func tappedCameraButton(_ sender: UIBarButtonItem) {
    output.tappedCameraButton()
  }
  
  @objc private func tappedNowPlayingButton(_ sender: UIBarButtonItem) {
    output.tappedNowplayingButton()
  }
  
  @objc private func tappedOtherButton(_ sender: UIBarButtonItem) {
    
  }
  
  func configure(sendButton isEnabled: Bool) {
    navigationItem.rightBarButtonItem?.isEnabled = isEnabled
  }
  
  func append(attachment: LocalAttachment) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.attachments.append(attachment)
      self.syncAttachment()
    }
  }
  
  func update(attachment: LocalAttachment) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      guard let index = self.attachments.firstIndex(where: { $0.id == attachment.id }) else { return }
      self.attachments[index] = attachment
      self.syncAttachment()
    }
  }
  
  private func syncAttachment() {
    let items = attachments.compactMap { (attachment) -> AttachmentDisplayItem in
      let status = attachment.status.message?.withFont(.systemFont(ofSize: 14)).withTextColor(.white)
      return AttachmentDisplayItem(id: attachment.id, image: attachment.image, status: status)
    }
    composeContentView.reload(using: items)
    mediaSourceButton.isEnabled = items.count < maxAttachmentCount
  }
  
  func presentMediaSourcePicker() {
    let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      sheet.addAction(.init(title: "Camera", style: .default, handler: { [weak self] (_) in
        self?.presentCamera()
      }))
    }
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      sheet.addAction(.init(title: "Album", style: .default, handler: { [weak self] (_) in
        self?.presentImagePicker()
      }))
    }
    sheet.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
    present(sheet, animated: true, completion: nil)
  }
  
  func removeAttachment(at index: Int) {
    attachments.remove(at: index)
    syncAttachment()
  }
  
  func configure(body: String) {
    composeContentView.text = body
    output.textDidChanged(text: composeContentView.text)
  }
}

extension ComposeViewController: UINavigationControllerDelegate & UIImagePickerControllerDelegate {
  private func presentCamera() {
    let camera = UIImagePickerController()
    camera.sourceType = .camera
    camera.delegate = self
    present(camera, animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true) { [weak self] in
      guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
      self?.output.didSelectImage(image)
    }
  }
}

extension ComposeViewController: NohanaImagePickerControllerDelegate {
  private func presentImagePicker() {
    checkIfAuthorizedToAccessPhotos { isAuthorized in
      DispatchQueue.main.async(execute: { [weak self] in
        if isAuthorized {
          self?.internalPresentImagePicker()
        } else {
          let alert = UIAlertController(title: "Error", message: "Denied access to photos.", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
          self?.present(alert, animated: true, completion: nil)
        }
      })
    }
  }
  
  private func internalPresentImagePicker() {
    let picker = NohanaImagePickerController(assetCollectionSubtypes: [.smartAlbumUserLibrary], mediaType: MediaType.photo, enableExpandingPhotoAnimation: true)
    picker.delegate = self
    picker.shouldShowMoment = false
    picker.shouldShowEmptyAlbum = false
    picker.maximumNumberOfSelection = maxAttachmentCount - attachments.count
    present(picker, animated: true, completion: nil)
  }
  
  private func checkIfAuthorizedToAccessPhotos(_ handler: @escaping (_ isAuthorized: Bool) -> Void) {
    switch PHPhotoLibrary.authorizationStatus() {
    case .notDetermined:
      PHPhotoLibrary.requestAuthorization { status in
        DispatchQueue.main.async {
          handler(status == .authorized)
        }
      }
    case .restricted, .denied:
      handler(false)
    case .authorized:
      handler(true)
    }
  }
  
  func nohanaImagePickerDidCancel(_ picker: NohanaImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func nohanaImagePicker(_ picker: NohanaImagePickerController,
                         didFinishPickingPhotoKitAssets pickedAssts: [PHAsset]) {
    output.didSelectAssets(pickedAssts)
    picker.dismiss(animated: true, completion: nil)
  }
}

extension ComposeViewController: AttachmentCollectionControlEventDelegate {
  func tappedAttachmentRemoveButton(at indexPath: IndexPath) {
    output.tappedRemoveAttachmentButton(at: indexPath.row)
  }
}
