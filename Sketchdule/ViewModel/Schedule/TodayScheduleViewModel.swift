import Foundation
import RealmSwift
import Combine

class TodayScheduleViewModel: ObservableObject {
    @Published var currentSubject = Schedule(time: "-", name: "Empty", location: "-", code: "-")
    @Published var anotherSubject = [Schedule]()
    var subscriptions = Set<AnyCancellable>()
    
    private let days = [0, 7, 1, 2, 3, 4, 5, 6] //ElliotDay
    private let day = Calendar.current.dateComponents([.weekday], from: Date()).weekday!
  
    var stringDate = ""
    
    let dayInWeek = ["", "อาทิตย์", "จันทร์", "อังคาร", "พุธ", "พฤหัสบดี", "ศุกร์", "เสาร์"]
    let month = ["", "มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม" , "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม"]
    
    
    let date = Date()
    var calendar = Calendar.current
    
    init() {
        Timer
            .publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink(receiveValue: { _ in
                self.currentSubject = DB().getCurrentSubject()
                self.anotherSubject = DB().getAnotherSubject()
                self.stringDate = "\(self.getDayOfWeek()) \(self.getDayOfMonth()) \(self.getMonth())"
        })
            .store(in: &subscriptions)
    }
    
    func getDayOfWeek() -> String {
        let components = Calendar.current.dateComponents([.weekday], from: Date())
        return dayInWeek[components.weekday!]
    }
    
    func getDayOfMonth() -> Int {
        let components = Calendar.current.dateComponents([.day], from: Date())
        return components.day!
    }
    
    func getMonth() -> String {
        let components = Calendar.current.dateComponents([.month], from: Date())
        return month[components.month!]
    }

    func getMinute() -> Int {
        let minute = Calendar.current.component(.minute, from: Date())
        return minute
    }
    
    func update() {
        currentSubject = DB().getCurrentSubject()
        anotherSubject = DB().getAnotherSubject()
        stringDate = "\(getDayOfWeek()) \(getDayOfMonth()) \(getMonth())"
    }
    
}
