import Foundation
struct Subject: Decodable, Identifiable {
    var id: String
    var name: String
    var code: String
}

struct SubjectList: Decodable {
    var list: [Subject]
}
