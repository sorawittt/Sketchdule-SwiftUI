import Foundation

struct UserApi: Decodable {
    var token: String
    var user: User
}

class LoginViewModel: ObservableObject {
    static let shared = LoginViewModel()
    
    @Published var username = ""
    @Published var pw = ""
    
    @Published var userDB = UserDB.shared
    
    @Published var canLogin = false
    
    @Published var showSheet = false
    
    @Published var loginError = ""
    
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
            let user = try? JSONDecoder().decode(UserApi.self, from: data)
            
            let test: String = user?.token ?? ""

            print(test)
            if test != "" {
                DispatchQueue.main.async {
                    let temp = UserModelDB()
                    temp.firstname = user!.user.firstname
                    temp.lastname = user!.user.lastname
                    temp.studentId = user!.user.studentId
                    temp.faculty = user!.user.faculty
                    temp.major = user!.user.major
                    temp.majorCode = user!.user.majorCode
                    temp.token = user!.token
                    temp.userId = user!.user.userId

                    //cal expire
                    let jwt = user!.token
                    var payload64 = jwt.components(separatedBy: ".")[1]
                    // need to pad the string with = to make it divisible by 4,
                    // otherwise Data won't be able to decode it
                    while payload64.count % 4 != 0 {
                        payload64 += "="
                    }


                    let payloadData = Data(base64Encoded: payload64,
                                           options:.ignoreUnknownCharacters)!
                    let json = try! JSONSerialization.jsonObject(with: payloadData, options: []) as! [String:Any]
                    let exp = json["exp"] as! Int
//                    let expDate = Date(timeIntervalSince1970: TimeInterval(exp))

                    temp.expire = String(exp)
                    userDB.writeUser(user: temp)
                    canLogin = true
                    loginError = ""
                    username = ""
                    pw = ""
                }
            } else {
                DispatchQueue.main.async {
                    loginError = "Username หรือ Password ไม่ถูกต้อง"
                }
            }
        }
        task.resume()
    }
}
