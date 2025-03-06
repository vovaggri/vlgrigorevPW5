//
//  WebPresenter.swift
//  vlgrigorevPW5

import UIKit

protocol WebPresenterProtocol {
    func routBackNews()
}

final class WebPresenter: WebPresenterProtocol {
    weak var webView: WebViewController?
    
    func routBackNews() {
        webView?.navigationController?.popViewController(animated: true)
    }
}
