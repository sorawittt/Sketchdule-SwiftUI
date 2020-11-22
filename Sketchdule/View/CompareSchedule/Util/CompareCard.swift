import SwiftUI
import ElliotableSwiftUI

struct CompareCard: View {
    let subject: ElliottEvent
    private let width = UIScreen.main.bounds.width
    private let hegiht = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("\(subject.startTime) - \(subject.endTime)")
                .font(.system(size: 24, weight: .bold))
            Text("\(subject.courseName) คน")
                .font(.system(size: 18))
        }
        .frame(width: width * 0.9, height: hegiht * 0.07)
        .padding(10)
        .background(Color(UIColor.systemGray5))
        .cornerRadius(10)
    }
}

struct CompareCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CompareCard(
                subject: ElliottEvent(courseId: "", courseName: "ไม่ว่าง 1", roomName: "", professor: "", courseDay: .monday, startTime: "8:00", endTime: "9:30", backgroundColor: .red)
            )
        }
        
    }
}
