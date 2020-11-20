import Foundation

struct AllScheduleViewModel {
    private var scheduleMonday: [Schedule]
    private var scheduleTuesday: [Schedule]
    private var scheduleWednesday: [Schedule]
    private var scheduleThursday: [Schedule]
    private var scheduleFriday: [Schedule]
    private var scheduleSatherday: [Schedule]
    private var scheduleSunday: [Schedule]
    var date: [[Schedule]]
    
    let db = DB()
    
    init() {
        self.scheduleMonday = db.subjectList(day: 2)
        self.scheduleTuesday = db.subjectList(day: 3)
        self.scheduleWednesday = db.subjectList(day: 4)
        self.scheduleThursday = db.subjectList(day: 5)
        self.scheduleFriday = db.subjectList(day: 6)
        self.scheduleSatherday = db.subjectList(day: 7)
        self.scheduleSunday = db.subjectList(day: 1)
        self.date = [scheduleMonday, scheduleTuesday, scheduleWednesday, scheduleThursday, scheduleFriday, scheduleSatherday, scheduleSunday]
    }

    
    func getSchedule(day: Int) -> [Schedule] {
        return date[day]
    }
}
