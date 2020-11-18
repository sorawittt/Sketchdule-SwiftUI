import Foundation

struct ScheduleApi: Decodable {
    var name: String
    var code: String
    var start: Time
    var end: Time
    var days: [String]
    var property: [String]
    var section: Int
    var room: String
}
