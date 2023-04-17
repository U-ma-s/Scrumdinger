//
//  ScrumsView.swift
//  Scrumdinger
//  
//  Created by umas on 2023/04/15
//  
//

import SwiftUI

struct ScrumsView: View {
    
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in//更新が起こる可能性があるのでbindingで渡す
                NavigationLink(destination: DetailView(scrum: $scrum)) {//編集画面で変更が起こる可能性があり，bindingを要求されているので$で渡す
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrum")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.sampleData))
    }
}
