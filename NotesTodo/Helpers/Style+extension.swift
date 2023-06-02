import SwiftUI

struct SignInUpTextField: TextFieldStyle {
  func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .frame(height: 30)
      .padding()
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(lineWidth: 1)
      )
  }
}

struct SignInUpButton: ButtonStyle {
  @State var background: Color
  @State var foreground: Color
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(height: 30)
      .foregroundColor(foreground)
      .padding()
      .background(background)
      .clipShape(RoundedRectangle(cornerRadius: 25))
  }
}

