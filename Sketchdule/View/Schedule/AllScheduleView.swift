import SwiftUI

struct AllScheduleView: View {
    
    @State private var selection = 0
    private let days: [String] = ["จ", "อ", "พ", "พฤ", "ศ", "ส", "อา"]
    private let select: [String] = ["วันจันทร์", "วันอังคาร", "วันพุธ", "วันพฤหัสบดี", "วันศุกร์", "วันเสาร์", "วันอาทิตย์"]
    
    let data = AllScheduleViewModel()
    
    var body: some View {
            VStack(spacing: 15) {
                Picker(selection: $selection, label: Text("")) {
                    ForEach(0..<days.count, id: \.self) { index in
                        Text(self.days[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                
                Text("\(select[selection])")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 18))
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        if data.getSchedule(day: selection).count > 0 {
                            ForEach(data.getSchedule(day: selection), id: \.code) { subject in
                                    SubjectCard(subject: subject)
                                }
                        } else {
                            EmptyRow()
                        }
                    }
                }
            }
        .navigationBarTitle("ตารางเรียนทั้งหมด")
    }
}

struct AllScheduleView_Previews: PreviewProvider {
    static var previews: some View {
            AllScheduleView()
    }
}

