import Foundation
import RealmSwift

class UserDB: ObservableObject {
    static let shared = UserDB()
    
    @Published var isLogin = false
    
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var studentId = ""
    @Published var faculty = ""
    @Published var major = ""
    @Published var majorCode = ""
    
    init() {
        isLogin = checkLogin()
    }
    
    let realm = try! Realm()
    
    func writeUser(user: UserModelDB) {
        try! realm.write({
            realm.add(user)
        })
        firstname = user.firstname
        lastname = user.lastname
        studentId = user.studentId
        faculty = user.faculty
        major = user.major
        majorCode = user.majorCode
        isLogin = true
    }
    
    func checkLogin() -> Bool {
        let result = realm.objects(UserModelDB.self).first
        
        if result != nil {
            let user = UserModelDB(value: result!)
            let expire = Int(user.expire)
            let expDate = NSDate(timeIntervalSince1970: TimeInterval(expire!))
            print("token expire: \(expDate)")
            let now = NSDate()
            if  ( now.timeIntervalSince(expDate as Date) > 0 ) {
                try! realm.write({
                    realm.delete(realm.objects(UserModelDB.self))
                })
                return false
            }
            firstname = user.firstname
            lastname = user.lastname
            studentId = user.studentId
            faculty = user.faculty
            major = user.major
            majorCode = user.majorCode
            return true
        }
        return false
    }

    func logout() {
        try! realm.write({
            realm.deleteAll()
        })
        isLogin = false
    }
    
    func getUser() -> User {
        return User(studentId: self.studentId, firstname: self.firstname, lastname: self.lastname, faculty: self.faculty, major: self.major, majorCode: self.majorCode)
    }
    
}
