//
//  NewsDetailView.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import SwiftUI
import Kingfisher

struct NewsDetailView: View {
    var articleViewModel: ArticleViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                btnBack
                Spacer()
                
            }
            .padding()
            
            KFImage(articleViewModel.imageAvatar)
                .placeholder({
                    ProgressView()
                })
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(articleViewModel.title)
                    .font(.headline)
                
                HStack {
                    Text(articleViewModel.author)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .multilineTextAlignment(.leading)
                    
                    Text(articleViewModel.publishDate)
                        .font(.system(size: 11, weight: .light, design: .rounded))
                        .multilineTextAlignment(.leading)
                }
                
                Text(articleViewModel.description)
                    .font(.subheadline)
                    .opacity(0.7)
                
            }.padding(.horizontal, 12)
            
            if articleViewModel.websiteUrl != nil {
                HStack {
                    Spacer()
                    Link("See More", destination: articleViewModel.websiteUrl!)
                }
                .padding(.horizontal)
                .padding(.top)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
