//
//  DailyScrum.swift
//  Scrumdinger
//  
//  Created by umas on 2023/04/15
//  
//

import Foundation

struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var lengthInMinutesDouble: Double {
        get {//getは，他のストアドプロパティなどから値を取得して，computedプロパティの値として返す処理．スクラムの長さをDouble値として取得する．
            Double(lengthInMinutes)
        }
        set {//setはプロパティに代入された値を使用して他のストアドプロパティなどを更新する処置．．スライダーが変化した時にlengthInMinutesを更新する.
            lengthInMinutes = Int(newValue)//newValueはsetterの引数を省略した場合のデフォルト名
        }
    }
    var theme: Theme
    var history: [History] = []
    
    //イニシャライザでidプロパティにデフォルト値を割り当てるイニシャライザを追加．パラメータにデフォルト値を定義しておくと、イニシャライザや関数を呼び出す際に、そのパラメータを省略できる
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map{Attendee(name: $0)}//[String]で渡された出席者名の配列を[Attendee]にmapする．
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
    
}

extension DailyScrum {
    struct Attendee: Identifiable, Codable {//各個人．初期化時に名前を要求
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    static var emptyScrum: DailyScrum{//EditDetailViewでユーザー入力の受け皿として使用
        DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
    }
}
//MARK: - Sample Data
extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design",
                   attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
                   lengthInMinutes: 10,
                   theme: .yellow),
        DailyScrum(title: "App Dev",
                   attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"],
                   lengthInMinutes: 5,
                   theme: .orange),
        DailyScrum(title: "Web Dev",
                   attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"],
                   lengthInMinutes: 5,
                   theme: .poppy)
    ]
}
