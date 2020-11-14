import Foundation

typealias Students = Student

class RegisterViewModel: ObservableObject {
    @Published var studentID = ""
    @Published var currentStudent = Student(firstname: "-", lastname: "-", faculty: "-", major: "-", majorCode: "-")
    @Published var canContinue = false
    
    func getDetail() {
        let json = ["studentId": studentID]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        let url = URL(string: "http://cnc.cs.sci.ku.ac.th:8088/getStudentDetail")!
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
            let student = try? JSONDecoder().decode(Students.self, from: data)
            DispatchQueue.main.async {
                self.currentStudent = student ?? Student(firstname: "ไม่พบข้อมูล", lastname: "ไม่พบข้อมูล", faculty: "ไม่พบข้อมูล", major: "ไม่พบข้อมูล", majorCode: "ไม่พบข้อมูล")
                
                if student != nil {
                    canContinue = true
                } else {
                    canContinue = false
                }
            }
        }
        task.resume()
    }
}
