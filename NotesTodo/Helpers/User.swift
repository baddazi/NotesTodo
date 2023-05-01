import Foundation
import SwiftUI
import FirebaseAuth

struct User: EnvironmentKey {
  static var  defaultValue: Self = mock
  var id: String
//  var email: String
  
  static let mock: Self = User(id: "TestUser")
}
