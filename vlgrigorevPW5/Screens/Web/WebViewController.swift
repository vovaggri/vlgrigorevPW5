//
//  WebViewController.swift
//  vlgrigorevPW5

import UIKit
import WebKit

final class WebViewController: UIViewController {
    private var interactor: WebBuisnessLogic?
    private var url: URL?
    private var webView: WKWebView = WKWebView()
    
    init(interactor: WebBuisnessLogic?, url: URL?) {
        self.interactor = interactor
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureWebView()
        webView.load(URLRequest(url: url!))
    }
    
    private func configureWebView() {
        view.addSubview(webView)
        webView.pinHorizontal(to: view)
        webView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        webView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
