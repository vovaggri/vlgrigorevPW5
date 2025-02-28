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
    
}

final class NewsInteractor: NewsBuisnessLogic, NewsDataStore {
    var presenter: NewsPresenterProtocol?
    private let articleWorker: ArticleWorkerProtocol
    
    init(presenter: NewsPresenterProtocol?, articleWorker: ArticleWorkerProtocol) {
        self.presenter = presenter
        self.articleWorker = articleWorker
    }
    
    func loadFreshNews() {
        <#code#>
    }
    
    func loadMoreNews() {
        <#code#>
    }
    
    
}
