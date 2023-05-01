import SwiftUI

struct NotesItemView: View {
  var title: String
  var date: Date = .now - 432000 * 2
    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(title)
            .fontWeight(.bold)
          Text(date.notesItemFormatting())
        }
        .padding(.vertical)
        .padding(.leading)
        Spacer()
      }
      .frame(maxWidth: .infinity)
    }
}

struct NotesItemView_Previews: PreviewProvider {
    static var previews: some View {
      NotesItemView(title: "Title", date: .now)
    }
}


private extension Date {
  func notesItemFormatting() -> String {
    if Calendar.current.isDateInToday(self) {
      return self.formatted(date: .omitted, time: .shortened)
    }
    
    if Calendar.current.date(byAdding: .day, value: -7, to: .now)! < self {
      return self.formatted(.dateTime.weekday(.wide))
    }
      
    return self.formatted(date: .numeric, time: .omitted)
  }
}
