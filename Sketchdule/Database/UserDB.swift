import Foundation
import RealmSwift

class UserDB: ObservableObject {
    static let shared = UserDB()
    
    @Published var isLogin = false
    
    init() {
        isLogin = checkLogin()
    }
    
    let realm = try! Realm()
    
    func writeUser(user: UserModelDB) {
        try! realm.write({
            realm.add(user)
        })
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
                return false
            }
            return true
        }
        return false
        
    }

    func logout() {
        try! realm.write({
            realm.delete(realm.objects(UserModelDB.self))
        })
        isLogin = false
    }
    
}
