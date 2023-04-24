//
//  ScrumStore.swift
//  Scrumdinger
//  
//  Created by umas on 2023/04/24
//  
//

import SwiftUI

@MainActor///@Publishedで宣言されたプロパティの変更がメインスレッドで行われることを保証．これにより，メインスレッドでのビューの更新とバックグラウンドでの非同期関数の対話を可能に
class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("scrums.data")//scrums.dataという名前のファイルのURLを返す
    }
    
    func load() async throws {
        let task = Task<[DailyScrum], Error> {///generic parameter tells the complier that your closure returns [DailyScrum] and can throw an Error
            let fileURL = try Self.fileURL()///エラーがthrowされる可能性があるのでtryで
            guard let data = try? Data(contentsOf: fileURL) else {
                return []///アプリの初回起動時には，scrums.dataは存在しないのでからの配列を返す
            }
            let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: data)
            return dailyScrums
        }
        let scrums = try await task.value//task内でJSONdecoderがエラーを投げればvalueプロパティにアクセスしたときにエラーが伝播する
        self.scrums = scrums
    }
    
    func save(scrums:[DailyScrum]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(scrums)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value///task.valueは放棄
    }
}
