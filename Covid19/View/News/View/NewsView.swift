//
//  NewsView.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var viewModel:NewsViewModel
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
            
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.categoryList,id:\.self) { category in
                            Text(category)
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundColor(category == viewModel.categorySelected ? .white : .black)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background (
                                    Capsule()
                                        .fill(category == viewModel.categorySelected ? Color(hex: .primaryColor) : Color.clear)
                                )
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.updateCategorySelected(to: category)
                                    }
                                }
                        }
                    }
                }
                
                Spacer()
            }.padding()
            
            AsyncContentView(source: viewModel) { articleViewModelList in
                List {
                    ForEach(articleViewModelList,id:\.id) { articleViewModel in
                        NavigationLink(destination: NewsDetailView(articleViewModel: articleViewModel)){
                            NewsFeedView(articleViewModel: articleViewModel)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarHidden(true)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
