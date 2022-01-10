//
//  AsyncContentView.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/9/22.
//

import SwiftUI

struct AsyncContentView<Source: LoadableObject, Content: View>: View {
    @ObservedObject var source: Source
    var content: (Source.Output) -> Content
    
    init(source: Source,
         @ViewBuilder content: @escaping (Source.Output) -> Content) {
        self.source = source
        self.content = content
    }
    
    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear(perform: source.load)
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(error: error, retryHandler: source.load)
        case .loaded(let output):
            content(output)
        }
    }
}

struct ErrorView: View {
    var error: NetworkError
    var retryHandler: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Text("Try Again!")
            
            Button {
                retryHandler()
            } label: {
                Text("Retry")
            }
            Spacer()
        }
    }
}
