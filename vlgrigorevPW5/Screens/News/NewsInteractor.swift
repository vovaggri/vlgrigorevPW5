//
//  NewsInteractor.swift
//  vlgrigorevPW5
//
//  Created by Vladimir Grigoryev on 26.02.2025.
//

import UIKit

protocol NewsBuisnessLogic {
    func loadFreshNews()
    func loadMoreNews()
    func routToWeb(_ urlModel: Models.RoutToWeb)
    func prepareNewsShare(_ idNews: Int?)
}

protocol NewsDataStore {
    var articles: [Models.ArticleModel] {get set}
}

final class NewsInteractor: NewsBuisnessLogic, NewsDataStore {
    enum Constants {
        static let textShare: String = "Share screen"
    }
    
    var articles: [Models.ArticleModel] = []
    private var presenter: NewsPresenterProtocol?
    private let articleWorker: ArticleWorkerProtocol?
    
    init(presenter: NewsPresenterProtocol?, articleWorker: ArticleWorkerProtocol?) {
        self.presenter = presenter
        self.articleWorker = articleWorker
    }
    
    func loadFreshNews() {
        print("Interactor works")
        articleWorker?.fetchNews(completion: { [weak self] result in
            switch result {
            case .success(let newsPage):
                guard let self = self else { return }
                self.articles = newsPage.news ?? []
                self.presenter?.presentNews(articles: self.articles, shouldEndRefreshing: true)
            case .failure(let error):
                print("Error \(error)")
            }
        })
    }
    
    func loadMoreNews() {
        articleWorker?.fetchNews(completion: { [weak self] result in
            switch result {
            case .success(let newsPage):
                guard let self = self else { return }
                self.articles += newsPage.news ?? []
                self.presenter?.presentNews(articles: self.articles, shouldEndRefreshing: true)
            case .failure(let error):
                print("Error \(error)")
            }
        })
    }
    
    func routToWeb(_ urlModel: Models.RoutToWeb) {
        presenter?.routToWeb(urlModel)
    }
    
    func prepareNewsShare(_ idNews: Int?) {
        let text = Constants.textShare
        let urlShare = URL(string: "https://news.myseldon.com/ru/news/index/\(idNews!)")
        let itemsShare: [Any] = [text, urlShare ?? []]
        let activityVC = UIActivityViewController(activityItems: itemsShare, applicationActivities: nil)
        presenter?.showShare(activityVC)
    }
}
