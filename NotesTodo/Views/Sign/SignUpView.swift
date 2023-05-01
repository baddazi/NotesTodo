import SwiftUI
import FirebaseAuth

struct SignUpView: View {
  @Environment(\.[key: \Throw.self]) var `throw`
  @State var email = ""
  @State var password = ""
  @State var password2 = ""
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("Enter credentianls for creating a account")
      VStack {
        TextField("Email", text: $email)
          .keyboardType(.emailAddress)
          .textFieldStyle(.roundedBorder)
        
        SecureField("Password", text: $password)
          .textFieldStyle(.roundedBorder)
        
        SecureField("Password", text: $password2)
          .textFieldStyle(.roundedBorder)
      }
      Spacer()
      Button {
        signUp()
      } label: {
        Text("Sign Up")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.bordered)
      .padding(.bottom, 50)
 
    }
    .padding(.top, 90)
    .padding()
    .navigationTitle("Sign Up")
  }
  
  func signUp() {
    _ = `throw`.task {
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      
    }
  }
}

struct SignUpView_Preview: PreviewProvider {
  static var previews: some View {
    SignUpView()
  }
}
