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
    //@State private var scrums = DailyScrum.sampleData//ここがsource of trurhの大元．
    @StateObject private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            //ScrumsView(scrums: $scrums)//子ビューたちに`@State`プロパティへのbindingを渡していく
            ScrumsView(scrums: $store.scrums) {//saveAction()のtrairing closureとしてTaskを使用
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
