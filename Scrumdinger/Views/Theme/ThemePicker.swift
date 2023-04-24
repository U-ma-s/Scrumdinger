//
//  ThemePicker.swift
//  Scrumdinger
//  
//  Created by umas on 2023/04/17
//  
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme///DetailEditView内で`@State`として宣言されているscrumプロパティへのbindingを受け取る．更新して返す処理はまだかな
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle))// .constant()はハードコードされたimmutableな値へのbindingを作成
    }
}
