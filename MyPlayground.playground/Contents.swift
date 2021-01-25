import UIKit

var json = """
"1": {
    "name": "Neha",
    "studentId": 326156,
    "academics": {
        "field": "iOS",
        "grade": "A"
    }
}
""".data(using: .utf8)!
struct Academics: Codable {
    var field: String
    var grade: String
}
struct Student: Codable {
    
    var name: String
    var studentId: Double
    var academics: Academics
    
}

let decoder = JSONDecoder()


do {
   let  student = try decoder.decode([String: Student].self, from: json)
    print(student)
} catch {
    print(error.localizedDescription)
}
