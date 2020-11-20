import Foundation

struct UserDetail: Decodable, Identifiable {
    var firstname: String
    var lastname: String
    var studentId: String
    var id: String
}

class CompareScheduleViewModel: ObservableObject {
    var userDB = UserDB.shared
    @Published var userList = [UserDetail]()
    
    init() {
        let temp = UserDetail(firstname: userDB.firstname, lastname: userDB.lastname, studentId: userDB.studentId, id: userDB.userId)
        userList.append(temp)
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
                print("statusCode: \(httpResponse.statusCode)")
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
        print(temp)
        return temp
    }
    
    func addUser(user: UserDetail) {
        if !(self.isContain(userId: user.id)) {
            userList.append(user)
        }
    }
    
    func removeUser(u: String) {
        userList = userList.filter() {
            $0.id != u
        }
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
    
    
    func getSelectUserSchedule() {
        var userIdList = [String]()
        for u in userList {
            userIdList.append(u.id)
        }
        let json = ["userIdList": userIdList]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)

        let url = URL(string: "http://cnc.cs.sci.ku.ac.th:3000/schedule/check")!
        var request = URLRequest(url: url)

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"

        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let stringValue = String(decoding: data!, as: UTF8.self)
            print(stringValue)
        }
        task.resume()
    }
}
