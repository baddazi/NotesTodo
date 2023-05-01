import SwiftUI
import FirebaseAuth

struct LoginView: View {
  @Environment(\.[key: \Throw.self]) var `throw`
  @State var email = "test@test.cz"
  @State var password = "12345678"
  
  var body: some View {
    VStack(spacing: 20) {
      Text("Enter credentianls for Log in")
      VStack {
        TextField("Email", text: $email)
          .keyboardType(.emailAddress)
          .textFieldStyle(.roundedBorder)
        
        SecureField("Password", text: $password)
          .textFieldStyle(.roundedBorder)
      }
      Spacer()
      Button {
        logIn() 
      } label: {
        Text("Log in")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.bordered)
      .padding(.bottom, 50)
 
    }
    .padding(.top, 90)
    .padding()
    .navigationTitle("Login")
  }
  
  func logIn() {
    _ = `throw`.task {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      print(result)
    }
  }
}

struct LoginView_Preview: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
