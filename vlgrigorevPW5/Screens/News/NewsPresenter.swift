//
//  NewsPresenter.swift
//  vlgrigorevPW5
//
//  Created by Vladimir Grigoryev on 26.02.2025.
//

protocol NewsPresenterProtocol {
    func presentNews(articles: [Models.ArticleModel])
}

final class NewsPresenter: NewsPresenterProtocol {
    weak var newsVC: NewsViewController?
    
    func presentNews(articles: [Models.ArticleModel]) {
        print("PresentNews works")
        let viewModel = Models.NewsViewModel(articles: articles)
        newsVC?.displayView(viewModel: viewModel)
    }
    
    
}
