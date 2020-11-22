

import SwiftUI
import ElliotableSwiftUI

struct ShowCompareScheduleView: View {
    @State private var selection = 0
    private let days: [String] = ["จ", "อ", "พ", "พฤ", "ศ", "ส", "อา"]
    private let select: [String] = ["วันจันทร์", "วันอังคาร", "วันพุธ", "วันพฤหัสบดี", "วันศุกร์", "วันเสาร์", "วันอาทิตย์"]
    
    let data = CompareScheduleViewModel.shared
    
    var body: some View {
            VStack(spacing: 15) {
                Picker(selection: $selection, label: Text("")) {
                    ForEach(0..<days.count, id: \.self) { index in
                        Text(self.days[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                
                Text("ช่วงเวลาที่ไม่ว่าง")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 18))
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        let compare = data.getSchedule(day: selection)
                        if compare.count > 0 {
                            ForEach(compare, id: \.startTime) { c in
                                CompareCard(subject: c)
                            }
                        } else {
                            EmptyCompareCard()
                        }
                    }
                }
            }
        .navigationBarTitle("ช่วงเวลาที่ไม่ว่าง")
    }
}


