//
//  NewsInteractor.swift
//  vlgrigorevPW5
//
//  Created by Vladimir Grigoryev on 26.02.2025.
//

protocol NewsBuisnessLogic {
    func loadFreshNews()
    func loadMoreNews()
    func routToWeb(_ urlModel: Models.RoutToWeb)
}

protocol NewsDataStore {
    var articles: [Models.ArticleModel] {get set}
}

final class NewsInteractor: NewsBuisnessLogic, NewsDataStore {
    var articles: [Models.ArticleModel] = []
    private var presenter: NewsPresenterProtocol?
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
    
    func routToWeb(_ urlModel: Models.RoutToWeb) {
        presenter?.routToWeb(urlModel)
    }
}
