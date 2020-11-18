import Foundation
import Combine

struct allSchedule: Decodable {
    var data: [[ScheduleApi]]
}

class SelectSubjectViewModel: ObservableObject {
    static let shared = SelectSubjectViewModel()
    
    @Published var selectSubject = [Subject]()
    
    @Published var userDB = UserDB.shared
    
    var click = 0
    
    @Published var isLoading = false
    @Published var loadComplete = false
    
    @Published var allCreateSchedule = [ElliotableSchedule]()
    
    private var cancellables = Set<AnyCancellable>()
    

    func addSubject(subject: Subject) {
        print("Adding: \(subject.name)")
        selectSubject.append(subject)
    }
    
    func removeSubject(c: String) {
        selectSubject = selectSubject.filter() {
            $0.code != c
        }
    }
    
    func isContain(c: String) -> Bool {
        for s in selectSubject {
            if s.code == c {
                return true
            }
        }
        return false
    }
    
    func getIndex(c: String) -> Int {
        guard let index = selectSubject.firstIndex(where: {
            $0.code == c
        }) else { return -1 }
        return index
    }
    
    func emptrySelectSubject() {
        selectSubject = [Subject]()
    }
    
    func test() {
        allCreateSchedule = [ElliotableSchedule]()
        var select = [String]()
        for s in selectSubject {
            select.append(s.code)
        }
        let user = userDB.getUser()
        let json: [String: Any] = ["codeList": select, "studentDetail": [
                                    "studentId": user.studentId,
                                    "firstname": user.firstname,
                                    "lastname": user.lastname,
                                    "faculty": user.faculty,
                                    "major": user.major,
                                    "majorCode": user.majorCode]]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        
        guard let url = URL(string: "http://cnc.cs.sci.ku.ac.th:3000/subject/check") else { return }
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let all = try! JSONDecoder().decode(allSchedule.self, from: data)
            
                var count = 1
                for sche in all.data {
                    var temp = ElliotableSchedule(name: ("แบบที่ " + "\(count)"))
                    for subj in sche {
                        let start = ("\(subj.start.hour):\(subj.start.minute)")
                        let end = ("\(subj.end.hour):\(subj.end.minute)")
                        let section = String(subj.section)
                        for day in subj.days {
                            var d = 1
                            if day == "SUN" { d = 7 }
                            else if day == "MON" { d = 1 }
                            else if day == "TUE" { d = 2}
                            else if day == "WED" { d = 3 }
                            else if day == "THU" { d = 4}
                            else if day == "FRI" { d = 5}
                            else if day == "SAT" { d = 6}
                            temp.subject.addCourse(elliotable: ElliotableModel(id: subj.code, name: subj.name, day: d, startTime: start, endTime: end, sec: section, room: subj.room))
                        }
                    }
                    print(count)
                    print("-----------")
                    print(temp.subject.uniqueList)
                    print("+++++++++++")
                    allCreateSchedule.append(temp)
                    count = count + 1
                }
                
            
        }
        task.resume()
    }
    
    func testDelay() {
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        isLoading = true
        guard let url = URL(string: "192.168.1.37:3000/subject/testLoad") else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, _) in
            print("2")
            semaphore.signal()
        })
        task.resume()
        print("1")
        semaphore.wait()
        print("c")
    }
    
}


