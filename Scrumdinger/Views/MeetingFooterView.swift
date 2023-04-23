//
//  MeetingFooterView.swift
//  Scrumdinger
//  
//  Created by umas on 2023/04/23
//  
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: ()->Void
    
    private var speakerNumber: Int? {//今話している人は何番目か
        guard let index = speakers.firstIndex(where: {!$0.isCompleted}) else { return nil }//isCompletedがfalseになる最初のindexを取得
        return index + 1//0-indexを1-indexにして返す
    }
    private var isLastSpeaker: Bool {//今のspeakerが最後か判定．最後以外のisCompletedがtrueの時，trueを返す
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "No more speakers"}
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Nesx speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
