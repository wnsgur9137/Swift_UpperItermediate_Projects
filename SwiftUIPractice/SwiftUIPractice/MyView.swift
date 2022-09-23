//
//  MyView.swift
//  SwiftUIPractice
//
//  Created by 이준혁 on 2022/09/23.
//

import SwiftUI

struct MyView: View {
    let helloFont: Font
    
//    SwiftUI가 언제든지 초기화하고 관리하기 때문에 아래와 같이 init() 함수같은 관리하는 함수를 생략하는 것이 좋다.
//    init() { }
    
    var body: some View {
        VStack {
            Text("first VStack")
                .font(helloFont)
            Text("Test")
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView(helloFont: .title)
    }
}
