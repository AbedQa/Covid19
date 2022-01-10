//
//  NewsView.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import SwiftUI

struct NewsView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("A look into collaborative wireframing process")
                        .font(.headline)
                    
                }
                
            }
            .navigationTitle("Latest Feed")
        }.frame(maxWidth: .infinity)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
