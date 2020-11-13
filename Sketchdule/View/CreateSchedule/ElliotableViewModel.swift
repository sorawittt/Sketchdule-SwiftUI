import Foundation
import ElliotableSwiftUI

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}


class ElliotableViewModel: ObservableObject {
    
    @Published var courseList = [ElliottEvent]()
    @Published var uniqueList = [ElliottEvent]()
    let color = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemGreen, UIColor.systemYellow, UIColor.systemOrange, UIColor.brown, UIColor.systemIndigo, UIColor.systemPink, UIColor.purple, UIColor.systemTeal, UIColor.black, UIColor.systemGray]
    private var tempColor = UIColor.random
    private var indexColor = 0

    func addCourse(elliotable: ElliotableModel) {
        var subjectColor = color[indexColor]
        if isContain(subject: elliotable) {
            subjectColor = tempColor
        } else {
            indexColor += 1
            uniqueList.append(ElliottEvent(courseId: elliotable.id, courseName: elliotable.name, roomName: elliotable.sec, professor: elliotable.room, courseDay: ElliotDay(rawValue: elliotable.day)!, startTime: elliotable.startTime, endTime: elliotable.endTime, backgroundColor: subjectColor))
        }
        courseList.append(ElliottEvent(courseId: elliotable.id, courseName: elliotable.name, roomName: elliotable.sec, professor: elliotable.room, courseDay: ElliotDay(rawValue: elliotable.day)!, startTime: elliotable.startTime, endTime: elliotable.endTime, backgroundColor: subjectColor))
    }
    
    func isContain(subject: ElliotableModel) -> Bool {
        for c in courseList {
            if c.courseId == subject.id {
                tempColor = c.backgroundColor
                return true
            }
        }
        return false
    }
    
}

