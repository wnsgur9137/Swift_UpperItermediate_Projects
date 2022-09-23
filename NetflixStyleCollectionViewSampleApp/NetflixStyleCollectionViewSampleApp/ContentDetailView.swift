//
//  ContentDetailView.swift
//  NetflixStyleCollectionViewSampleApp
//
//  Created by 이준혁 on 2022/09/23.
//

import SwiftUI

struct ContentDetailView: View {
    // 외부 자극 없이 내부의 어떤 상태가 어떻게 변화 될 것인지를 표시하는 프로퍼티 래퍼
    @State var item: Item?
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack(alignment: .bottom) {
                if let item = item {
                    Image(uiImage: item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                    Text(item.description)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.primary)
                        .background(Color.primary.colorInvert().opacity(0.75))
                } else {
                    // 그냥 흰 배경 보여줌
                    Color.white
                }
            }
        }
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item0 = Item(description: "흥미진진, 판타지, 애니메이션, 액션, 멀티캐스팅", imageName: "poster0")
        ContentDetailView(item: item0)
    }
}
