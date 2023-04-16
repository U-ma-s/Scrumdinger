//
//  DetailEditView.swift
//  Scrumdinger
//  
//  Created by umas on 2023/04/16
//  
//

import SwiftUI

struct DetailEditView: View {
    
    @State private var scrum = DailyScrum.emptyScrum
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesDouble, in: 5...30, step: 1) {
                        //closure内で()-> view な関数処理としてtextを宣言．これは非表示でアクセシビリティに使用．
                        Text("Length")
                    }
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")//ここはsourh of truthを変更しない（読み取りのみ）ので$不要．
                    
                }
        
            } header: {
                Text("Meeting Info")
            }

        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView()
    }
}
