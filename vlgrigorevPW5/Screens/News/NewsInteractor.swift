//
//  NewsInteractor.swift
//  vlgrigorevPW5
//
//  Created by Vladimir Grigoryev on 26.02.2025.
//

protocol NewsBuisnessLogic {
    func loadFreshNews()
    func loadMoreNews()
}

protocol NewsDataStore {
    var articles: [Models.ArticleModel] {get set}
}

final class NewsInteractor: NewsBuisnessLogic, NewsDataStore {
    var presenter: NewsPresenterProtocol?
    var articles: [Models.ArticleModel] = []
    private let articleWorker: ArticleWorkerProtocol?
    
    init(presenter: NewsPresenterProtocol?, articleWorker: ArticleWorkerProtocol?) {
        self.presenter = presenter
        self.articleWorker = articleWorker
    }
    
    func loadFreshNews() {
        print("testFreshNews")
        articleWorker?.fetchNews(completion: { [weak self] result in
            switch result {
            case .success(let newsPage):
                guard let self = self else { return }
                self.articles = newsPage.news ?? []
                self.presenter?.presentNews(articles: self.articles)
            case .failure(let error):
                print("Error \(error)")
            }
        })
    }
    
    func loadMoreNews() {
        print("testMoreNews")
    }
    
    
}
