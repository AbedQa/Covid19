//
//  TrackingItemView.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/10/22.
//

import SwiftUI

struct TrackingItemView: View {
    
    var trackItemViewModel: TrackItemViewModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 2) {
            HStack {
                Image(trackItemViewModel.trackImage)
                Text(trackItemViewModel.trackTitle)
                    .scaledFont(name: .regular, size: 11)
            }
            .padding(.top, 10)
            .padding(.leading)
            
            HStack {
                Text(trackItemViewModel.trackCases)
                    .scaledFont(name: .bold, size: 20)
            }
            .padding(.leading)
            .padding(.top, 4)
            
            HStack(alignment: .top) {
                Text("People")
                    .scaledFont(name: .regular, size: 9)
                    .padding(.leading)
                    .padding(.top , 5)
                Spacer()
                Image("mainLine")
            }
            .padding(.bottom, 4)
        }
        
        .frame(alignment: .leading)
        .background(Color
                        .white
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 5, y: 5)
        )
    }
}

