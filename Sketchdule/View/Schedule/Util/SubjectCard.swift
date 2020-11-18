import SwiftUI

struct SubjectCard: View {
    let subject: Schedule
    private let width = UIScreen.main.bounds.width
    
    var body: some View {
        HStack(spacing: width * 0.05) {
            VStack(alignment: .leading, spacing: 10) {
                Text(subject.time)
                Text(subject.name)
            }
                .frame(width: width * 0.45, height: 50).fixedSize(horizontal: false, vertical: true)
            .padding(.leading, 3)
                .font(.system(size: 16, weight: .bold))
            VStack( spacing: 10) {
                Text(subject.location)
                Text(subject.code)
            }
                .frame(width: width * 0.40, height: 50, alignment: .center).fixedSize(horizontal: false, vertical: true)
                .font(.system(size: 16, weight: .medium))
        }
        .frame(width: width * 0.9,alignment: .leading)
        .padding(10)
        .background(Color(UIColor.systemGray5))
        .cornerRadius(10)
    }
}

struct SubjectCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SubjectCard(
                subject: Schedule(time: "10:00 - 14:00", name: "Software Engineer", location: "Online/SC45-710", code: "01418471")
            )
            SubjectCard(
                subject: Schedule(time: "10:00 - 14:00", name: "Cloud Computing", location: "SC45-710", code: "01418471")
            )
        }
        
    }
}
