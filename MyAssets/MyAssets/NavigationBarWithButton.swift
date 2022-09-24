//
//  NavigationBarWithButton.swift
//  MyAssets
//
//  Created by 이준혁 on 2022/09/23.
//

import SwiftUI

// ViewModifier -> 뷰에 함수처럼 적용할 수 있다.
struct NavigationBarWithButton: ViewModifier {
    var title: String = ""
    func body(content: Content) -> some View {
        
        return content
            .navigationBarItems(
                leading: Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .padding(),
                trailing: Button(
                    action: {
                        print("자산추가버튼 tapped")
                    }, label: {
                        Image(systemName: "plus")
                        Text("자산추가")
                            .font(.system(size: 12))
                    }
                )
                .accentColor(.black)
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black)
                )
            )
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                let apperance = UINavigationBarAppearance()
                apperance.configureWithTransparentBackground()
                apperance.backgroundColor = UIColor(white: 1, alpha: 0.5)
                UINavigationBar.appearance()
                    .standardAppearance = apperance
                UINavigationBar.appearance()
                    .compactAppearance = apperance
                UINavigationBar.appearance()
                    .scrollEdgeAppearance = apperance
            }
    }
}

// 이를 통해 다른 뷰에서 적용 가능하다.
extension View {
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
//        NavigationBarWithButton()
    }
}
