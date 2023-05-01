import SwiftUI

extension EnvironmentValues {
  subscript<Key: EnvironmentKey>(key keyPath: KeyPath<Key, Key>) -> Key.Value {
    get { self[Key.self] }
    set { self[Key.self] = newValue }
  }
}

