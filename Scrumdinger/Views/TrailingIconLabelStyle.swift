//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//  
//  Created by umas on 2023/04/15
//  
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {//　文字->アイコンの順に並ぶようにした
            configuration.title
            configuration.icon
        }
    }
    
}

//MARK: - インスタンス生成に必要な構文をカプセル化
extension LabelStyle where Self == TrailingIconLabelStyle {//trairingIconプロパティは，自身の型がTrairingIconLabelStyleの場合のみ使用できる
    static var trairingIcon: Self { Self()}//TrairingIconLabelStyle型のtrairingIconプロパティを宣言し，インスタンスをクロージャ内のSelf()で初期化している．
}
