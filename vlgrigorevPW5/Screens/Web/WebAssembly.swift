//
//  WebAssembly.swift
//  vlgrigorevPW5

import UIKit

final class WebAssembly {
    static func assembly(with url: URL?) -> UIViewController {
        let presenter = WebPresenter()
        let interactor = WebInteractor(presenter: presenter)
        let webVC = WebViewController(interactor: interactor, url: url)
        presenter.webView = webVC
        
        return webVC
    }
}
