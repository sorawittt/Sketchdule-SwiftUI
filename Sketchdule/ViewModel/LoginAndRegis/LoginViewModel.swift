import Foundation

class LoginViewModel: ObservableObject {
    static let shared = LoginViewModel()
    
    @Published var username = ""
    @Published var pw = ""
    
    @Published var showSheet = false
    
    func login() {
        let json = ["username": username, "password": pw,]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: "http://cnc.cs.sci.ku.ac.th:9900/auth/login")!
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
            let str = String(decoding: data, as: UTF8.self)
            print(str)
        }
        task.resume()
    }
}
