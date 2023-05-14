import SwiftUI

struct NotesItemView: View {
  @State var note: NotesTodo
  
    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(note.text.separateTitle())
            .fontWeight(.bold)
          Text(note.date.notesItemFormatting())
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
      NotesItemView(note: .sample)
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
