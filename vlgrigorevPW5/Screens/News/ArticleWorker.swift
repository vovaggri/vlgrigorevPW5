//
//  NewsWorker.swift
//  vlgrigorevPW5
//
//  Created by Vladimir Grigoryev on 28.02.2025.
//

import Foundation

protocol ArticleWorkerProtocol {
    func fetchNews(completion: @escaping (Result<Models.NewsPage, Error>) -> Void)
}

final class ArticleWorker: ArticleWorkerProtocol {
    private let decoder: JSONDecoder = JSONDecoder()
    private var newsPage: Models.NewsPage = Models.NewsPage()
    
    func fetchNews(completion: @escaping (Result<Models.NewsPage, Error>) -> Void) {
        guard let url = getURL(4, 1) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            
            if
                let self = self,
                let data = data,
                var newsPage = try? self.decoder.decode(Models.NewsPage.self, from: data)
            {
                newsPage.passTheRequestId()
                self.newsPage = newsPage
                completion(.success(newsPage))
            }
        }.resume()
    }
    
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }
}
