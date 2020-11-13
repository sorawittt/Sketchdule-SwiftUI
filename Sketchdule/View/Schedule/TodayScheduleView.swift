import Foundation
import SwiftUI
import Combine

struct TodayScheduleView: View {
    @ObservedObject var data = TodayScheduleViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(data.stringDate).font(.system(size: 20, weight: .bold))
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    Text("ขณะนี้")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 15))
                    if data.currentSubject.name == "Empty" {
                            EmptyRow()
                    } else {
                        SubjectCard(subject: data.currentSubject)
                    }
                Text("วิชาต่อไป")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 15))
                if (data.anotherSubject.count > 0) {
                        ForEach(0..<data.anotherSubject.count, id: \.self) { i in
                            SubjectCard(subject: self.data.anotherSubject[i])
                        }
                } else {
                    EmptyRow()
                }
                
                }.padding(.top, 8)
            }
            .navigationBarTitle("ตารางเรียน")
            .navigationBarItems(trailing:
                HStack{
                    NavigationLink(destination: AllScheduleView()) {
                        Text("ทั้งหมด").font(.system(size: 15))
                    }
                })
            }
        }.onAppear() {
            data.update()
        }
    }
}

struct AllSchedule_Previews: PreviewProvider {
    static var previews: some View {
        TodayScheduleView()
    }
}
