//
//  WebViewController.swift
//  vlgrigorevPW5

import UIKit
import WebKit

final class WebViewController: UIViewController {
    enum Constants {
        static let returnButtonName: String = "chevron.left"
        static let invalidUrl: String = "Invalid URL!"
    }
    
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
        
        let returnButton = UIBarButtonItem(image: UIImage(systemName: Constants.returnButtonName), style: .plain, target: self, action: #selector(returnButtonPressed))
        navigationItem.leftBarButtonItem = returnButton
        
        configureWebView()
        
        guard let url = url else {
            print(Constants.invalidUrl)
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    private func configureWebView() {
        view.addSubview(webView)
        webView.pinHorizontal(to: view)
        webView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        webView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    @objc private func returnButtonPressed() {
        interactor?.returnButtonLogic()
    }
}
