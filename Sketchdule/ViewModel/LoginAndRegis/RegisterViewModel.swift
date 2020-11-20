import Foundation
import Combine

extension String {
    func matches() -> Bool {
        return self.range(of: "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,}$", options: .regularExpression, range: nil, locale: nil) != nil
    }
}

class RegisterViewModel: ObservableObject {
    public static let shared = RegisterViewModel()
    
    @Published var studentID = ""
    @Published var currentStudent = Student(firstname: "-", lastname: "-", faculty: "-", major: "-", majorCode: "-")
    @Published var canContinue = false
    
    @Published var username = ""
    @Published var pw = ""
    @Published var confirmPW = ""
    
    @Published var errorUsername = ""
    @Published var errorPW = ""
    
    @Published var isValid = false
    
    @Published var showAlert = false
    @Published var status = ""
    
    private var cancellableSet = Set<AnyCancellable>()
    
    init() {
        isFormValidPublisher
          .receive(on: RunLoop.main)
          .assign(to: \.isValid, on: self)
          .store(in: &cancellableSet)
        
        isUsernameValidPublisher
              .receive(on: RunLoop.main)
              .map { valid in
                valid ? "" : "Username จะต้องมีความยาวอย่างน้อย 6 ตัวอักษร"
              }
              .assign(to: \.errorUsername, on: self)
              .store(in: &cancellableSet)
            
            isPasswordValidPublisher
              .receive(on: RunLoop.main)
              .map { passwordCheck in
                switch passwordCheck {
                case .empty:
                  return "กรุณากรอก Password"
                case .notCorrect:
                  return "Password จะต้องประกอบด้วยตัวอักษรภาษาอังกฤษพิมพ์เล็ก, พิมพ์ใหญ่, ตัวอักษรพิเศษ, ตัวเลข และมีความยาวอย่างน้อย 6 ตัวอักษร"
                case .noMatch:
                  return "Password ไม่ตรงกัน"
                default:
                  return ""
                }
              }
              .assign(to: \.errorPW, on: self)
              .store(in: &cancellableSet)
      }
    
    
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
            let student = try? JSONDecoder().decode(Student.self, from: data)
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
    
    func signup() {
        let json: [String : Any] = ["username": username, "password": pw, "studentId": studentID, "roles": [[
                        "name": "ROLE_ADMIN", "description": "ADMIN"]] ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: "http://cnc.cs.sci.ku.ac.th:9900/auth/signup")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let _ = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200 {
                        status = ""
                        showAlert = true
                    } else if httpResponse.statusCode == 400 {
                        showAlert = true
                        status = "400"
                    } else {
                        showAlert = true
                        status = "500"
                    }
                }
            }
        }
        task.resume()
    }
    
    private var isUsernameValidPublisher: AnyPublisher<Bool, Never> {
        $username
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { input in
            return input.count >= 6
          }
          .eraseToAnyPublisher()
      }
    
    private var arePasswordsEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($pw, $confirmPW)
          .debounce(for: 0.2, scheduler: RunLoop.main)
          .map { password, passwordAgain in
            return password == passwordAgain
          }
          .eraseToAnyPublisher()
      }
    
    private var isPasswordCorrectPublisher: AnyPublisher<Bool, Never> {
        $pw
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                return password.matches()
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $pw
          .debounce(for: 0.8, scheduler: RunLoop.main)
          .removeDuplicates()
          .map { password in
            return password == ""
          }
          .eraseToAnyPublisher()
      }
    
    enum PasswordCheck {
        case empty
        case notCorrect
        case noMatch
        case valid
      }
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
        Publishers.CombineLatest3(isPasswordEmptyPublisher, arePasswordsEqualPublisher, isPasswordCorrectPublisher)
          .map { passwordIsEmpty, passwordsAreEqual, passwordIsValid in
            if (passwordIsEmpty) {
                return .empty
            }
            else if (!passwordIsValid) {
                return .notCorrect
            }
            else if (!passwordsAreEqual) {
                return .noMatch
            }
            return .valid
          }
          .eraseToAnyPublisher()
      }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isUsernameValidPublisher, isPasswordValidPublisher)
          .map { usernameIsValid, passwordIsValid in
            return usernameIsValid && (passwordIsValid == .valid)
          }
        .eraseToAnyPublisher()
      }
    
    func reset() {
        studentID = ""
        currentStudent = Student(firstname: "-", lastname: "-", faculty: "-", major: "-", majorCode: "-")
        canContinue = false
        
        username = ""
        pw = ""
        confirmPW = ""
        
        errorUsername = ""
        errorPW = ""
        
        isValid = false
        
        showAlert = false
        status = ""
    }
}
