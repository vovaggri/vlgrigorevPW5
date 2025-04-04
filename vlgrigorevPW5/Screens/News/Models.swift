//
//  Models.swift
//  vlgrigorevPW5
//
//  Created by Vladimir Grigoryev on 28.02.2025.
//

import UIKit

enum Models {
    struct ArticleModel: Decodable {
        var newsId: Int?
        var title: String?
        var announce: String?
        var img: ImageContainer?
        var requestId: String?
        var articleUrl: URL? {
            let requestId = requestId ?? ""
            let newsId = newsId ?? 0
            return URL(string: "https://news.myseldon.com/ru/news/index/\(newsId)?requestId=\(requestId)")
        }
    }
    
    struct ImageContainer: Decodable {
        var url: URL?
    }
    
    struct NewsPage: Decodable {
        var news: [ArticleModel]?
        var requestId: String?
        mutating func passTheRequestId() {
            for i in 0..<(news?.count ?? 0) {
                news?[i].requestId = requestId
            }
        }
    }
    
    struct NewsViewModel {
        let articles: [Models.ArticleModel]
        let shouldEndRefreshing: Bool
    }
    
    struct RoutToWeb {
        let articleURL: URL?
    }
    
    struct ShareNews {
        let id: Int?
        let shareVC: UIActivityViewController
    }
}
