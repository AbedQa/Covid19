//
//  NewsFeedView.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import SwiftUI
import Kingfisher

struct NewsFeedView: View {
    var articleViewModel: ArticleViewModel
    var body: some View {
        HStack {
            KFImage(articleViewModel.imageAvatar)
                .placeholder({
                    ProgressView()
                })
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .clipped()
                .cornerRadius(12)
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text(articleViewModel.title)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)

                HStack {
                    Text(articleViewModel.author)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    Spacer()
                    Text(articleViewModel.publishDate)
                        .font(.system(size: 11, weight: .light, design: .rounded))
                        .multilineTextAlignment(.leading)
                }
                
            }.padding(.horizontal, 12)
        }
        .padding(12)
    }
}
