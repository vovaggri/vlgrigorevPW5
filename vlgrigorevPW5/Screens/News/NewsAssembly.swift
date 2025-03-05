//
//  NewsAssembly.swift
//  vlgrigorevPW5
//
//  Created by Vladimir Grigoryev on 28.02.2025.
//

import UIKit

// SVIP architecture
final class NewsAssembly {
    static func assembly() -> UIViewController {
        let presenter = NewsPresenter()
        let articleWorker = ArticleWorker()
        let interactor = NewsInteractor(presenter: presenter, articleWorker: articleWorker)
        let newsVC = NewsViewController(interactor: interactor)
        presenter.newsVC = newsVC
        
        return newsVC
    }
}
