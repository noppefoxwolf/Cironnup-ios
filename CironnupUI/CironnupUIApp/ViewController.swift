//
//  ViewController.swift
//  CironnupUIApp
//
//  Created by Tomoya Hirano on 2018/10/26.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit
import CironnupUI

class ViewController: UIViewController {
  @IBOutlet weak var collectionView: AttachmentCollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func stepperValueChanged(_ sender: UIStepper) {
    let images = [UIImage(named: "landscape")!, UIImage(named: "portrait")!, UIImage(named: "square")!]
    let statuses: [NSAttributedString?] = [NSAttributedString(string: "uploading"), nil]
    let attachments = (0..<(Int(sender.value) % 5)).map({ AttachmentDisplayItem.init(id: $0, image: images.randomElement()!, status: statuses.randomElement()!) })
    print(attachments.count)
    collectionView.reload(using: attachments)
  }
}

