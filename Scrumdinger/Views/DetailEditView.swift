//
//  DetailEditView.swift
//  Scrumdinger
//  
//  Created by umas on 2023/04/16
//  
//

import SwiftUI

struct DetailEditView: View {
    
    //@State private var scrum = DailyScrum.emptyScrum//ユーザーの入力の受け皿として使用
    @Binding var scrum: DailyScrum//編集元のデータとしてDetailViewの`@State`プロパティをbindingで受け取る．このviewで更新すると，親ビューでも反映される
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $scrum.title)//書き込みがあるので$（バインディング）が必要
                HStack {
                    Slider(value: $scrum.lengthInMinutesDouble, in: 5...30, step: 1) {
                        //closure内で()-> view な関数処理としてtextを宣言．これは非表示でアクセシビリティに使用．
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")//ここはsourh of truthを変更しない（読み取りのみな）ので$不要．
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)//ThemePickerにscrum.themeへのbinding（読み書きアクセス）を渡す
            } header: {
                Text("Meeting Info")
            }
            Section {
                ForEach(scrum.attendees) { attendee in//既存の参加者
                    Text(attendee.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)//新規追加する参加者名を保持する．textfeildを$でnewAttendeeと同期
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)//ここではnewAttendeeを参照するだけなので$不要
                            scrum.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            } header: {
                Text("Attendees")
            }


        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))//`@Binding`プロパティの初期化に必要なbindingデータを.constantで作れるのか
    }
}
