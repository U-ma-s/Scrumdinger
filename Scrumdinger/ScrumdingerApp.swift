//
//  ScrumdingerApp.swift
//  Scrumdinger
//  
//  Created by umas on 2023/04/15
//  
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData//ここがsource of trurhの大元．
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)//子ビューたちに`@State`プロパティへのbindingを渡していく
        }
    }
}
