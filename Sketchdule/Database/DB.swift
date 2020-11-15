import Foundation
import RealmSwift

struct DB {
    
    private let days = [0, 7, 1, 2, 3, 4, 5, 6] //ElliotDay
    private let day = Calendar.current.dateComponents([.weekday], from: Date()).weekday!
    
    let date = Date()
    let calendar = Calendar.current
    
    let realm = try! Realm()
    
    func addSubject(subject: ElliotableViewModel) {
        try! realm.write({
            realm.delete(realm.objects(SubjectModelDB.self))
        })
        for s in subject.courseList {
            let temp = SubjectModelDB()
            temp.code = s.courseId
            temp.name = s.courseName
            temp.location = s.professor
            temp.startTime = s.startTime
            temp.endTime = s.endTime
            temp.day = s.courseDay.rawValue
            
            try! realm.write({
                realm.add(temp)
            })
        }
    }
    
    func getAnotherSubject() -> [Schedule] {
        let inFormatter = DateFormatter()
        inFormatter.dateFormat = "HH:mm"
        inFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let result = realm.objects(SubjectModelDB.self).filter("day == \(days[day])").sorted(byKeyPath: "startTime", ascending: true)
        var list = [Schedule]()
        
        for s in result {
            let temp = SubjectModelDB(value: s)
            let startTime = temp.startTime.components(separatedBy: ":")
            let endTime = temp.endTime.components(separatedBy: ":")

            let startHour = Int(startTime[0]) ?? 0
            let startMinute = Int(startTime[1]) ?? 0
            let endHour = Int(endTime[0]) ?? 0
            let endMinute = Int(endTime[1]) ?? 0

            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)

            if ((hour < startHour) || (hour == startHour && minutes < startMinute)) {
                let timeString = toTimeFormat(sHour: startHour, sMinute: startMinute, eHour: endHour, eMinute: endMinute)
                list.append(Schedule(time: timeString, name: temp.name, location: temp.location, code: temp.code))
            }
        }
        
        return list
    }
    
    func getCurrentSubject() -> Schedule {
        let inFormatter = DateFormatter()
        inFormatter.dateFormat = "HH:mm"
        inFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let result = realm.objects(SubjectModelDB.self).filter("day == \(days[day])").sorted(byKeyPath: "startTime", ascending: true)
    
        for s in result {
            let temp = SubjectModelDB(value: s)
            let startTime = temp.startTime.components(separatedBy: ":")
            let endTime = temp.endTime.components(separatedBy: ":")

            let startHour = Int(startTime[0]) ?? 0
            let startMinute = Int(startTime[1]) ?? 0
            let endHour = Int(endTime[0]) ?? 0
            let endMinute = Int(endTime[1]) ?? 0

            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)

            if (((hour > startHour) || (hour == startHour && minutes >= startMinute)) && ((hour < endHour) || (hour == endHour && minutes < endMinute))) {
                
                let timeString = toTimeFormat(sHour: startHour, sMinute: startMinute, eHour: endHour, eMinute: endMinute)
                return Schedule(time: timeString, name: temp.name, location: temp.location, code: temp.code)
            }
        }
        return Schedule(time: "-", name: "Empty", location: "-", code: "-")
    }
    
    func subjectList(day: Int) -> [Schedule] {
        let result = realm.objects(SubjectModelDB.self).filter("day == \(days[day])").sorted(byKeyPath: "startTime", ascending: true)
        var list = [Schedule]()
        for s in result {
            let temp = SubjectModelDB(value: s)
            let stringTime = temp.startTime + " - " + temp.endTime
            list.append(Schedule(time: stringTime, name: temp.name, location: temp.location, code: temp.code))
        }
        return list
    }
    
    private func toTimeFormat(sHour: Int, sMinute: Int, eHour: Int, eMinute: Int) -> String {
        return String(format: "%02d:%02d - %02d:%02d", sHour, sMinute, eHour, eMinute)
    }
    
    func deleteAllSchedule() {
        try! realm.write({
            realm.delete(realm.objects(SubjectModelDB.self))
        })
    }
    
}
