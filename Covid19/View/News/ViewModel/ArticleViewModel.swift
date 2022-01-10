//
//  ArticleViewModel.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import Foundation

struct ArticleViewModel: Identifiable {
    var id: String = UUID().uuidString
    private var article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var imageAvatar: URL? {
        URL(string: article.urlToImage ?? "")
    }
    
    var websiteUrl: URL? {
        URL(string: article.url ?? "")
    }
    
    var content: String {
        article.content ?? ""
    }
    
    var title: String {
        article.title ?? ""
    }
    
    var description: String {
        article.articleDescription ?? ""
    }
    
    var author: String {
        article.author ?? ""
    }
    
    var publishDate: String {
        return dateConverter(dateString: article.publishedAt, fromDateFormatter: "yyyy-MM-dd'T'HH:mm:ssZ", toDateFormatter: "yyyy-MM-dd")
    }
    
    private func dateConverter(dateString: String?,fromDateFormatter: String , toDateFormatter: String) -> String {
        guard let dateString = dateString else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromDateFormatter
        dateFormatter.locale = Locale(identifier: "en")
        let date = dateFormatter.date(from: dateString)
        if let date = date {
            dateFormatter.dateFormat = toDateFormatter
            let convertedDate = dateFormatter.string(from: date)
            return convertedDate
        }
        return ""
    }
}

