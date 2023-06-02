import Foundation
import SwiftUI
import FirebaseAuth

struct User: EnvironmentKey {
  typealias ID = String
  static var  defaultValue: Self = sample
  var id: ID
//  var email: String
  
  static let sample: Self = User(id: "TestUser")
}
