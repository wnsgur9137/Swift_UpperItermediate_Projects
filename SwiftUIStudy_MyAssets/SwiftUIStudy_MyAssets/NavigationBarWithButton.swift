//
//  NavigationBarWithButton.swift
//  SwiftUIStudy_MyAssets
//
//  Created by 이준혁 on 2022/09/28.
//

import SwiftUI

struct NavigationBarWithButton: ViewModifier {    // View 수정자
    // ViewModifier는 함수처럼 사용 가능하다.
    
    var title: String = ""
    
    func body(content: Content) -> some View {
        return content
            .navigationBarItems(
                leading: Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .padding(),
                trailing: Button(
                    action: {
                        print("자산추가 버튼 tapped")
                    },
                    label: {
                        Image(systemName: "plus")
                        Text("자산추가")
                            .font(.system(size: 12))
                    }
                )
                .accentColor(.black)
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .overlay(   // 덧씌운다.
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black)   // 내부에 어떠한 채움 없이 테두리만 뽑아낸다.
                )
            )
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.backgroundColor = UIColor(white: 1, alpha: 0.5)
                UINavigationBar.appearance()
                    .standardAppearance = appearance
                UINavigationBar.appearance()
                    .compactAppearance = appearance
                UINavigationBar.appearance()
                    .scrollEdgeAppearance = appearance
            }
    }
}

extension View {    // 변수가 직접적으로 이 함수를 사용 가능하게 한다.
    func navigationBarWithButtonStyle(_ title: String) -> some View {
        return self.modifier(NavigationBarWithButton(title: title))
    }
}

struct NavigationBarWithButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Color.gray.edgesIgnoringSafeArea(.all)
                .navigationBarWithButtonStyle("내 자산")
        }
    }
}
