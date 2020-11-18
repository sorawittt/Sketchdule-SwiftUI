import Foundation

class Course: Decodable {
    var start: Time
    var end: Time
    var days: [String]
    var property: [String]
    var section: Int
    var room: String
}
