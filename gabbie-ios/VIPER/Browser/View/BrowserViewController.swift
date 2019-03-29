//
//  BrowserViewController.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 06/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import WebKit
import GabKit
import OnePasswordExtension

final class BrowserViewController: UIViewController, BrowserViewInput, AlwaysModalyPresenting {
  let navigationControllerType: UINavigationController.Type? = UINavigationController.self
  let animatedWhenPresent: Bool = true
  
  var output: BrowserViewOutput!
  private lazy var url: URL = { preconditionFailure() }()
  private lazy var configuration: WKWebViewConfiguration = .init()
  private lazy var webView: WKWebView = .init(frame: .zero, configuration: configuration)
  private lazy var progressView: UIProgressView = .init(progressViewStyle: .bar)
  private var progressObservation: NSKeyValueObservation? = nil
  private lazy var goBackButton: UIBarButtonItem = { preconditionFailure() }()
  private lazy var goForwardButton: UIBarButtonItem = { preconditionFailure() }()
  
  convenience init(url: URL) {
    self.init(nibName: nil, bundle: nil)
    self.url = url
    let configurator = BrowserModuleConfigurator()
    configurator.configureModuleForViewInput(viewInput: self)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }
  
  // MARK: BrowserViewInput
  func setupInitialState() {
  }
  
  func setupUI() {
    let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDoneButton))
    navigationItem.leftBarButtonItem = button
    
    webView.uiDelegate = self
    webView.navigationDelegate = self
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.allowsBackForwardNavigationGestures = true
    view.addSubview(webView)
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: view.topAnchor),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      webView.leftAnchor.constraint(equalTo: view.leftAnchor),
      webView.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
    progressObservation = webView.observe(\.estimatedProgress, options: .new) { [weak self] (_, change) in
      guard let progress = change.newValue else { return }
      self?.progressView.setProgress(Float(progress), animated: true)
    }

    CookieCleaner.clean()
    let request = URLRequest(url: url)
    webView.load(request)
    
    progressView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(progressView)
    NSLayoutConstraint.activate([
      progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      progressView.leftAnchor.constraint(equalTo: view.leftAnchor),
      progressView.rightAnchor.constraint(equalTo: view.rightAnchor),
    ])
    
    let toolbar = UIToolbar(frame: .zero)
    toolbar.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(toolbar)
    NSLayoutConstraint.activate([
      toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      toolbar.leftAnchor.constraint(equalTo: view.leftAnchor),
      toolbar.rightAnchor.constraint(equalTo: view.rightAnchor),
    ])
    
    goBackButton = .make(image: Asset.Browser.goBack.image, target: self,
                         action: #selector(tappedGoBackButton))
    goForwardButton = .make(image: Asset.Browser.goForward.image, target: self,
                            action: #selector(tappedGoForwardButton))
    let shareButton = UIBarButtonItem.make(image: Asset.Browser.share.image, target: self,
                                           action: #selector(tappedShareButton))
    let safariButton = UIBarButtonItem.make(image: Asset.Browser.safari.image, target: self,
                                            action: #selector(tappedSafariButton))
    let spacer = { UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) }
    let items = [goBackButton, goForwardButton, shareButton, safariButton]
    let fixedItems = items.reduce(into: [], { $0.append(contentsOf: [$1, spacer()]) }).dropLast()
    toolbar.setItems(Array(fixedItems), animated: false)
  }
  
  func fillReturnedItems(_ items: [Any]) {
    OnePasswordExtension.shared().fillReturnedItems(items, intoWebView: webView, completion: { _,_ in })
  }
}

extension BrowserViewController {
  @objc private func tappedDoneButton(_ sender: UIBarButtonItem) {
    output.tappedDoneButton()
  }
  
  @objc private func tappedGoBackButton(_ sender: UIBarButtonItem) {
    webView.goBack()
  }
  
  @objc private func tappedGoForwardButton(_ sender: UIBarButtonItem) {
    webView.goForward()
  }
  
  @objc private func tappedShareButton(_ sender: UIBarButtonItem) {
    let opExt = OnePasswordExtension.shared()
    let url = webView.url
    opExt.createExtensionItem(forWebView: webView) { [weak self] (item, error) in
      self?.output.tappedSharedButton(with: [item as Any, url as Any].compactMap({ $0 }))
    }
  }
  
  @objc private func tappedSafariButton(_ sender: UIBarButtonItem) {
    guard let url = webView.url else { return }
    output.tappedSafariButton(url: url)
  }
}

extension BrowserViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView,
               decidePolicyFor navigationAction: WKNavigationAction,
               decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url
    switch url {
    case .some(let url) where url.absoluteString.hasPrefix("http"): break
    case .some(let url) where url.absoluteString.hasPrefix("gabbie"):
      Gab.handleURL(url)
    default: break
    }
    decisionHandler(.allow)
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    progressView.setProgress(0, animated: false)
    goBackButton.tintColor = webView.canGoBack ? nil : .gray
    goBackButton.isEnabled = webView.canGoBack
    goForwardButton.tintColor = webView.canGoForward ? nil : .gray
    goForwardButton.isEnabled = webView.canGoForward
  }
}

extension BrowserViewController: WKUIDelegate {
  
}

