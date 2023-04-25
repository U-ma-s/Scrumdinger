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
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            //ScrumsView(scrums: $scrums)//子ビューたちに`@State`プロパティへのbindingを渡していく
            ScrumsView(scrums: $store.scrums) {//saveAction()のtrairing closureとしてTaskを使用
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidence: "Try again later")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidence: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {//onDismiss() closure.モーダル解除時にトリガーされる．
                store.scrums = DailyScrum.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
