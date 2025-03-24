//
//  NewsPresenter.swift
//  vlgrigorevPW5
//
//  Created by Vladimir Grigoryev on 26.02.2025.
//

import UIKit

protocol NewsPresenterProtocol {
    func presentNews(articles: [Models.ArticleModel])
    func routToWeb(_ urlModel: Models.RoutToWeb)
    func showShare(_ shareVC: UIActivityViewController)
}

final class NewsPresenter: NewsPresenterProtocol {
    weak var newsVC: NewsViewController?
    
    func presentNews(articles: [Models.ArticleModel]) {
        let viewModel = Models.NewsViewModel(articles: articles)
        newsVC?.displayView(viewModel: viewModel)
    }
    
    func routToWeb(_ urlModel: Models.RoutToWeb) {
        newsVC?.navigationController?.pushViewController(WebAssembly.assembly(with: urlModel.articleURL), animated: true)
    }
    
    func showShare(_ shareVC: UIActivityViewController) {
        newsVC?.present(shareVC, animated: true)
    }
}
