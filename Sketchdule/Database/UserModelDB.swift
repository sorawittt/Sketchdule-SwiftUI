import Foundation
import RealmSwift

class UserModelDB: Object {
    @objc var token = ""
    @objc var studentId = ""
    @objc var firstname = ""
    @objc var lastname = ""
    @objc var faculty = ""
    @objc var major = ""
    @objc var majorCode = ""
    @objc var expire = ""
    @objc var userId = ""
}
