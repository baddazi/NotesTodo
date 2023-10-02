import Combine
import Foundation
import SwiftUI

struct Throw: EnvironmentKey {
  static var defaultValue: Self = .init()
  var handleError: (Error) -> Void = { error in
    let info = error.localizedDescription + ", \(error)"
    logger.info("Unhandled user-facing error: \(info, privacy: .public)")
#if DEBUG
    raise(SIGINT) // trigger a breakpoint
#endif
  }
}

extension Throw {
  func callAsFunction(_ error: Error) {
    self.handleError(error)
  }
  
  func `try`(_ work: () throws -> Void) {
    do {
      try work()
    } catch {
      self(error)
    }
  }
  
  func `try`(_ work: @escaping () async throws -> Void) async {
    do {
      try await work()
    } catch {
      self(error)
    }
  }
  
  func task(_ work: @escaping () async throws -> Void) -> Task<Void, Never> {
    Task { @MainActor in
      await `try`(work)
    }
  }
}

struct ShowErrors: ViewModifier {
  @State private var errors: [Error] = []
  @State private var showError = false
  @Environment(\.[key: \Throw.self]) var `throw`
  
  func body(content: Content) -> some View {
    content
      .environment(\.[key: \Throw.self], Throw { error in
        logger.error("\(error.localizedDescription)\n\(error)")
        errors.append(error)
        if !showError {
          showError = true
        }
      })
      .alert(isPresented: $showError)
    {
      if errors.count == 1 {
        return Alert(
          title: Text("Error"),
          message: Text(errors.first!.localizedDescription),
          dismissButton: .cancel({ errors = [] })
        )
      }
      else {
        return Alert(
          title: Text("\(errors.count) Errors occurred"),
          message: Text(errors.first!.localizedDescription),
          primaryButton: .destructive(
            Text("Hide all"),
            action: { errors = [] }
          ),
          secondaryButton: .default(
            Text("Move to next Error"),
            action: { moveToNextError() }
          )
        )
      }
    }
  }
  
  func moveToNextError() {
    Task { @MainActor in
      self.showError = errors.showError()
    }
  }
}

extension View {
  func showErrors() -> some View {
    modifier(ShowErrors())
  }
}

extension Array where Element: Error {
  mutating func showError() -> Bool {
    self.removeFirst()
    return !self.isEmpty
  }
}


