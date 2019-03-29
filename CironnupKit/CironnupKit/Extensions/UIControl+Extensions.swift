//
//  UIControl+Extensions.swift
//  CironnupKit
//
//  Created by Tomoya Hirano on 2018/11/12.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

class ClosureSleeve {
  let closure: ()->()
  
  init (_ closure: @escaping ()->()) {
    self.closure = closure
  }
  
  @objc func invoke () {
    closure()
  }
}

extension UIControl {
  public func addAction(for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
    let sleeve = ClosureSleeve(closure)
    addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    objc_setAssociatedObject(self, UUID().uuidString, sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
  }
}

extension UIBarButtonItem {
  public convenience init(title: String?, _ closure: @escaping ()->()) {
    let sleeve = ClosureSleeve(closure)
    self.init(title: title, style: .plain, target: sleeve, action: #selector(ClosureSleeve.invoke))
    objc_setAssociatedObject(self, UUID().uuidString, sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
  }
  
  public convenience init(image: UIImage?, _ closure: @escaping ()->()) {
    let sleeve = ClosureSleeve(closure)
    self.init(image: image, style: .plain, target: sleeve, action: #selector(ClosureSleeve.invoke))
    objc_setAssociatedObject(self, UUID().uuidString, sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
  }
}


