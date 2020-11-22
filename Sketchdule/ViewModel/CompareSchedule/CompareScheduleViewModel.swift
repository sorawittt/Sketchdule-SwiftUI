import Foundation
import ElliotableSwiftUI

struct UserDetail: Decodable, Identifiable {
    var firstname: String
    var lastname: String
    var studentId: String
    var id: String
}

struct DataApi: Decodable {
    var data: [Courses]
}

struct Courses: Decodable {
    var courses: [ScheduleApi]
}

class CompareScheduleViewModel: ObservableObject {
    static let shared = CompareScheduleViewModel()
    var userDB = UserDB.shared
    @Published var userList = [UserDetail]()
    @Published var compare = [ElliottEvent]()
    
    //27
    var time = ["8:00", "8:30", "9:00", "9:30", "10:00", "10:30" , "11:00", "11:30" , "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00"]
    var mon = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var tue = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var wed = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var thu = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var fri = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var sat = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var sun = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var days = [[Int]]()
    
    
    init() {
        days = [mon, tue, wed, thu, fri, sat, sun]
    }
    
    
    func searchUser(u: String) -> UserDetail{
        let sem = DispatchSemaphore.init(value: 0)
        let url = URL(string: "http://cnc.cs.sci.ku.ac.th:9900/users/username/\(u)")!
        var temp = UserDetail(firstname: "", lastname: "-", studentId: "-", id: "-")
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer { sem.signal() }
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let user = try? JSONDecoder().decode(UserDetail.self, from: data)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    temp.firstname = user!.firstname
                    temp.lastname = user!.lastname
                    temp.studentId = user!.studentId
                    temp.id = user!.id
                }
            }
        }
        task.resume()
        sem.wait()
        return temp
    }
    
    func addUser(user: UserDetail) {
        if !(self.isContain(userId: user.id)) {
            userList.append(user)
        }
        setSchedule(id: user.id, method: "add")
    }

    func removeUser(user: UserDetail) {
        userList = userList.filter() {
            $0.id != user.id
        }
        setSchedule(id: user.id, method: "delete")
    }


    func isContain(userId: String) -> Bool {
        for u in userList {
            if u.id == userId {
                return true
            }
        }
        return false
    }
    
    func resetList() {
        userList = [UserDetail]()
    }
    
    func setSchedule(id: String, method: String) {
        let sem = DispatchSemaphore.init(value: 0)
        var userIdList = [String]()
        let max = userList.count
        userIdList.append(id)
        let json = ["userIdList": userIdList]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)

        let url = URL(string: "http://cnc.cs.sci.ku.ac.th:3000/schedule/check")!
        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"

        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            defer { sem.signal() }
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let all = try! JSONDecoder().decode(DataApi.self, from: data)
            
            for sche in all.data {
                for subj in sche.courses {
                    let start = ("\(subj.start.hour):\(subj.start.minute)")
                    let end = ("\(subj.end.hour):\(subj.end.minute)")
                    for day in subj.days {
                        var inrange = false
                        var d = 0
                        if day == "SUN" { d = 6 }
                        else if day == "MON" { d = 0 }
                        else if day == "TUE" { d = 1 }
                        else if day == "WED" { d = 2 }
                        else if day == "THU" { d = 3 }
                        else if day == "FRI" { d = 4 }
                        else if day == "SAT" { d = 5 }
                        
                        for i in 0...self.time.count-1 {
                            if (start == self.time[i] || end == self.time[i] || inrange){
                                if method == "add" {
                                    if self.days[d][i] < max {
                                        self.days[d][i] += 1
                                    }
                                } else if method == "delete" {
                                    if self.days[d][i] > 0 {
                                        self.days[d][i] -= 1
                                    }
                                }
                                if start == self.time[i] {
                                    inrange = true
                                } else if end == self.time[i] {
                                    inrange = false
                                } else {
                                }
                            }
                        }
                    }
                }
            }
        }
        task.resume()
        sem.wait()
    }
    
    func getSchedule(day: Int) -> [ElliottEvent] {
        if compare.isEmpty {
            toEllioSchedule()
        }
        var temp = [ElliottEvent]()
        for s in compare {
            if s.courseDay == ElliotDay(rawValue: day) {
                temp.append(s)
            }
        }
        return temp
    }
    
    func reset() {
        compare = [ElliottEvent]()
    }
    
    private func toEllioSchedule() {
        for d in 0...days.count - 1 {
            var lastTime = ""
            var lastCount = -1
            for i in 0...time.count - 1 {
                if (days[d][i] != 0 && lastTime == "") {
                    lastTime = time[i]
                    lastCount = days[d][i]
                } else if (lastCount != days[d][i] && lastCount > 0) {
                    var color:UIColor = UIColor.systemYellow
                    if lastCount == 1 {
                        color = UIColor.systemYellow
                    } else if lastCount == 2 {
                        color = .orange
                    } else if lastCount == 3 {
                        color = UIColor.systemOrange
                    } else if lastCount == 4 {
                        color = UIColor.systemRed
                    } else {
                        color = .red
                    }
                    compare.append(ElliottEvent(courseId: String(lastCount), courseName: String("ไม่ว่าง \(lastCount)"), roomName: "", professor: "", courseDay: ElliotDay(rawValue: d+1)!, startTime: lastTime, endTime: time[i], backgroundColor: color))
                    if (days[d][i] != 0) {
                        lastTime = time[i]
                        lastCount = days[d][i]
                    } else {
                        lastTime = ""
                        lastCount = -1
                    }
                }
            }
        }
    }
    
    
}
