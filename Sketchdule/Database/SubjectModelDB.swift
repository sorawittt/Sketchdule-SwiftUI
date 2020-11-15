import Foundation
import RealmSwift

class SubjectModelDB: Object {
    @objc var code = ""
    @objc var name = ""
    @objc var location = ""
    @objc var startTime = ""
    @objc var endTime = ""
    @objc var day = 0
}
