//
//  NewsPresenter.swift
//  vlgrigorevPW5
//
//  Created by Vladimir Grigoryev on 26.02.2025.
//

protocol NewsPresenterProtocol {
    func presentNews()
}

final class NewsPresenter: NewsPresenterProtocol {
    weak var newsVC: NewsViewController?
    
    func presentNews() {
        <#code#>
    }
    
    
}
