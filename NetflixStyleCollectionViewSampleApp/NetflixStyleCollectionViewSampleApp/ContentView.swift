//
//  ContentView.swift
//  NetflixStyleCollectionViewSampleApp
//
//  Created by 이준혁 on 2022/09/23.
//

import SwiftUI

struct ContentView: View {
    let titles = ["Netfilx Sample App"]
    var body: some View {
        NavigationView {
            List(titles, id: \.self) {
                let netflixVC = HomeViewControllerRepresentable()
                    .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)
                NavigationLink($0, destination: netflixVC)
            }
            .navigationTitle("SwiftUI to UIKit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
