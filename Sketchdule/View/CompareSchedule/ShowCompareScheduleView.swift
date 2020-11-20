

import SwiftUI
import ElliotableSwiftUI

struct ShowCompareScheduleView: View {
    var data: [ElliottEvent]
    var body: some View {
        VStack {
            Text("zzz")
            generateTimetableView()
        }
    }
    private func generateTimetableView() -> ElliotableView {
        let temp = data
        print(temp)
        let daySymbols = ["จ", "อ", "พ", "พฤ", "ศ", "ส", "อา"]
        let elliotableView = ElliotableView()
        elliotableView.courseList(list: temp)
        elliotableView.dayCount(count: 6)
        elliotableView.daySymbols(symbols: daySymbols)
        elliotableView.borderColor(color: Color(.sRGB, red: 0.7, green: 0.7, blue: 0.7, opacity: 1))
        elliotableView.headerFont(font: .system(size: 14, weight: .bold))
        elliotableView.symbolBackgroundColor(color: Color(.sRGB, red: 0.97, green: 0.97, blue: 0.97, opacity: 1))
        elliotableView.timeHeaderTextColor(color: Color(.sRGB, red: 0.6, green: 0.6, blue: 0.6, opacity: 1))
        return elliotableView
    }
}


