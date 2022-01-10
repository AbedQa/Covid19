//
//  TrackingView.swift
//  Covid19
//
//  Created by AbdelrahmanQasim on 1/10/22.
//

import SwiftUI
import GridStack

struct TrackingView: View {
    var size = UIScreen.main.bounds
    @ObservedObject var viewModel: TrackViewModel = .init()
    @State private var fitInScreen = false
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        GeometryReader { gp in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ZStack {
                        Color(hex: .primaryColor)
                            .opacity(0.1)
                            .clipShape(CustomShape(corner: [.bottomLeft,.bottomRight], size: 50))
                        
                        VStack {
                            HStack {
                                NavigationLink(destination: CountryView(viewModel: .init(), onConfirmSelected: { countryName in
                                    viewModel.updateCountry(countryName: countryName)
                                })) {
                                    Text(viewModel.countrySelectedItem)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .background(
                                            Capsule()
                                                .fill(Color(hex: .primaryColor))
                                        )
                                }
                                
                                Spacer()
                                
                                NavigationLink(destination: NewsView(viewModel: .init(countrySelectedItem: viewModel.countrySelectedItem))) {
                                   Image(systemName: "newspaper")
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .background(
                                            Capsule()
                                                .fill(Color(hex: .primaryColor))
                                        )
                                }
                            }
                            .padding(.top)
                            .padding(.horizontal)
                            
                            DatePicker("Start Date", selection: $viewModel.startDate, displayedComponents: .date)
                                .datePickerStyle(DefaultDatePickerStyle())
                                .padding(.horizontal)
                                .padding(.top)
                            
                            DatePicker("End Date", selection: $viewModel.endDate, displayedComponents: .date)
                                .datePickerStyle(DefaultDatePickerStyle())
                                .padding(.horizontal)
                            
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.refershData()
                                } label: {
                                    Image("refresh")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color(hex: .primaryColor))
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            Spacer()
                            AsyncContentView(source: viewModel) { trackItemListViewModel in
                                
                                GridStack(minCellWidth: 150, spacing: 10, numItems: 4) { index, cellWidth in
                                    TrackingItemView(trackItemViewModel: trackItemListViewModel[index])
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                        }
                    }.frame(height: size.height * 0.75, alignment: .leading)
                    
                    Text("Preventions")
                        .scaledFont(name: .bold, size: 20)
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                    
                    HStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Image("washHands")
                            
                            Text("Wash Hands")
                                .foregroundColor(Color(hex: .primaryColor))
                                .scaledFont(name: .medium, size: 15)
                        }
                        Spacer()
                        VStack(spacing: 8) {
                            Image("mask")
                            
                            Text("Use Masks")
                                .foregroundColor(Color(hex: .primaryColor))
                                .scaledFont(name: .medium, size: 15)
                        }
                        Spacer()
                        VStack(spacing: 8) {
                            Image("cleanDisinfect")
                            
                            Text("Clean Disinfect")
                                .foregroundColor(Color(hex: .primaryColor))
                                .scaledFont(name: .medium, size: 15)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Image("note")
                            .frame(alignment: .leading)
                        ZStack(alignment: .topTrailing) {
                            Image("covidLogo")
                            VStack(alignment: .leading,spacing: 8) {
                                Text("Dial 999 for\nMedical Help!")
                                    .scaledFont(name: .medium, size: 17)
                                    .foregroundColor(.white)
                                
                                Text("If any symptoms appear")
                                    .scaledFont(name: .regular, size: 12)
                                    .foregroundColor(.white.opacity(0.3))
                            }
                            .frame(maxWidth: .infinity ,alignment: .leading)
                        }
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity ,maxHeight: 131)
                    .background(
                        Color(hex: .primaryColor)
                            .cornerRadius(10)
                            .shadow(color: Color(hex: .primaryColor).opacity(0.4), radius: 8, x: 5, y: 5)
                    )
                    .padding()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.load()
        }
    }
}

struct TrackingView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingView()
    }
}

