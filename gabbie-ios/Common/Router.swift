//
//  Router.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/13.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Router
import GabKit
import Lightbox
import SafariServices
import CironnupKit

protocol AlwaysModalyPresenting {
  var navigationControllerType: UINavigationController.Type? { get }
  var animatedWhenPresent: Bool { get }
}
extension AlwaysModalyPresenting {
  var animatedWhenPresent: Bool { return true }
}


enum ProfileTarget {
  case me
  case user(username: String)
}

enum GabNavigation: Navigation {
  case authorize
  case inSessin(Account)
  case timeline(Account, TimelineInteractable)
  case compose(Account, ReplyMode)
  case imageViewer(URL, [URL])
  case browser(URL)
  case notifications(Credential)
  case profile(ProfileTarget, Credential)
  case settings
  case settingMenu(AnySettingMenu<String>)
  case tipjar
  case group(Account)
}

struct GabAppNavigation: AppNavigation {
  func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
    guard let navigation = navigation as? GabNavigation else { preconditionFailure() }
    switch navigation {
    case .authorize:
      return StoryboardScene.Authorize.initialScene.instantiate()
    case .inSessin(let account):
      let credential = account.clientSource.credential
      let vc = StoryboardScene.InSession.initialScene.instantiate()
      vc.setupInitialState(credential: credential)
      let tc = viewcontrollerForNavigation(navigation: GabNavigation.timeline(account, TimelineInteractor()))
      let tnc = NavigationController(rootViewController: tc)
      tnc.tabBarItem = .make(image: Asset.Icons.home.image)
      let gc = viewcontrollerForNavigation(navigation: GabNavigation.group(account))
      let ngc = NavigationController(rootViewController: gc)
      ngc.tabBarItem = .make(image: Asset.Icons.groups.image)
      let nc = viewcontrollerForNavigation(navigation: GabNavigation.notifications(credential))
      let nnc = NavigationController(rootViewController: nc)
      nnc.tabBarItem = .make(image: Asset.Icons.activity.image)
      let pc = viewcontrollerForNavigation(navigation: GabNavigation.profile(.me, credential))
      let npc = NavigationController(rootViewController: pc)
      npc.tabBarItem = .make(image: Asset.Icons.profile.image)
      vc.viewControllers = [tnc, ngc, nnc, npc]
      return vc
    case .timeline(let account, let interactor):
      let vc = TimelineViewController()
      let configurator = TimelineModuleConfigurator()
      configurator.configureModuleForViewInput(viewInput: vc, interactor: interactor)
      vc.setupInitialState(account: account)
      return vc
    case .compose(let account, let replyMode):
      let vc = ComposeViewController.make(reply: replyMode)
      vc.setupInitialState(account: account)
      return vc
    case .imageViewer(let url, let urls):
      let images = urls.map({ LightboxImage.init(imageURL: $0) })
      let startIndex = urls.firstIndex(of: url) ?? 0
      let imageViewer = ImageViewerViewController(images: images, startIndex: startIndex)
      imageViewer.dynamicBackground = true
      return imageViewer
    case .browser(let url):
      let vc = BrowserViewController(url: url)
      return vc
    case .notifications(let credential):
      let vc = NotificationsViewController()
      let configurator = NotificationsModuleConfigurator()
      configurator.configureModuleForViewInput(viewInput: vc)
      vc.setupInitialState(credential: credential)
      return vc
    case .profile(let target, let credential):
      let vc = StoryboardScene.Profile.initialScene.instantiate()
      vc.setupInitialState(target, credential: credential)
      return vc
    case .settings:
      let vc = StoryboardScene.Settings.initialScene.instantiate()
      return vc
    case .settingMenu(let settingMenu):
      let vc = SettingMenuViewController<String>.make(settingMenu: settingMenu)
      return vc
    case .tipjar:
      let vc = StoryboardScene.TipJar.initialScene.instantiate()
      return vc
    case .group(let account):
      let vc = GroupViewController()
      let configurator = GroupModuleConfigurator()
      configurator.configureModuleForViewInput(viewInput: vc)
      vc.setupInitialState(account: account)
      return vc
    }
  }
  
  func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
    if let root = from as? RootViewController {
      self.flip(from: root, to: to)
    } else {
      self.navigate(from: from, to: to)
    }
  }
  
  private func flip(from: RootViewController, to: UIViewController) {
    from.configure(to)
  }
  
  private func navigate(from: UIViewController, to: UIViewController) {
    if let vc = to as? AlwaysModalyPresenting & UIViewController {
      if vc is UINavigationController {
        from.present(vc, animated: vc.animatedWhenPresent, completion: nil)
      } else {
        if let nc = vc.navigationControllerType?.init(rootViewController: vc) {
          from.present(nc, animated: vc.animatedWhenPresent, completion: nil)
        } else {
          from.present(vc, animated: vc.animatedWhenPresent, completion: nil)
        }
      }
    } else if let nc = from as? UINavigationController {
      to.hidesBottomBarWhenPushed = true
      nc.pushViewController(to, animated: true)
    } else if let nc = from.navigationController {
      to.hidesBottomBarWhenPushed = true
      nc.pushViewController(to, animated: true)
    } else if let tc = from as? UITabBarController, let sc = tc.selectedViewController {
      navigate(from: sc, to: to)
    }
  }
}

extension IsRouter {
  func navigate(_ navigation: GabNavigation, from: UIViewController) {
    DispatchQueue.main.async {
      self.navigate(navigation as Navigation, from: from)
    }
  }
  
  func flip(_ navigation: GabNavigation) {
    DispatchQueue.main.async {
      if let root = UIApplication.shared.keyWindow?.rootViewController as? RootViewController {
        self.navigate(navigation as Navigation, from: root)
      }
    }
  }
}
