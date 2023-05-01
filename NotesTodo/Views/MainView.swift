import SwiftUI
import FirebaseAuth

struct MainView: View {
  @Environment(\.[key: \Throw.self]) var `throw`
  @State private var search: String = ""
  @FocusState private var focusedField: Field?
  
  enum Field: Hashable {
    case search
  }
  
  var body: some View {
    NavigationStack {
      VStack {
        ScrollView {
          searchField
          notesItems
        }
      }
      .navigationDestination(for: NotesTodo.self) { note in
        NotesDetailView(id: note.id, date: note.date, text: note.text)
      }
      .navigationTitle("Notes")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Menu {
            Button("Sign out", action: signOut)
            Button("Test errors", action: testError)
          } label: {
            Image(systemName: "ellipsis.circle")
          }
        }
      }
      .padding()
    }
  }
  
  @ViewBuilder
  var notesItems: some View {
    let filteredValues = search.count == 0 ? NotesTodo.sample : NotesTodo.sample.filter{ $0.text.contains(search) }
    
    VStack(spacing: 0) {
      ForEach(Array(filteredValues.enumerated()), id: \.1) { index, note in
        NavigationLink(value: note) {
          NotesItemView(title: note.text.separateTitle())
        }
        .foregroundColor(Color.black)
        if index != NotesTodo.sample.count - 1 {
          Divider()
        }
      }
    }
    .background(
      Color("ItemBackground")
        .cornerRadius(10)
    )
  }
  
  var searchField: some View {
    ZStack {
      TextField("Search", text: $search)
        .padding(.leading, 25)
        .focused($focusedField, equals: .search)
      HStack {
        Image(systemName: "magnifyingglass")
          .foregroundColor(Color("MagnifyingGlass"))
          .onTapGesture {
            focusedField = .search
          }
        Spacer()
      }
    }
    .padding(5)
    .background(
      Color("ItemBackground")
        .cornerRadius(10))
  }
  
  func signOut() {
    `throw`.try {
      try Auth.auth().signOut()
    }
  }
  
  func testError() {
    `throw`.try {
      throw SimpleError(errorDescription: "Test1")
    }
    `throw`.try {
      throw SimpleError(errorDescription: "Test2")
    }
    `throw`.try {
      throw SimpleError(errorDescription: "Test3")
    }
    `throw`.try {
      throw SimpleError(errorDescription: "Test4")
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
