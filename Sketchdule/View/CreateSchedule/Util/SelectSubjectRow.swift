import SwiftUI

struct SelectSubjectRow: View {
    var subjectCell: Subject
    @ObservedObject var selectSubject = SelectSubjectViewModel.shared
    @Environment(\.editMode) var editMode
    
    
    var body: some View {
        HStack {
            if (editMode?.wrappedValue == .active) {
                Text("\(subjectCell.code) | \(subjectCell.name)")
                    .font(.system(size: 15))
                    .frame(minWidth: 0, maxWidth: 230, alignment: .leading).fixedSize(horizontal: true, vertical: true)
            } else {
                Text("\(subjectCell.code) | \(subjectCell.name)")
                    .font(.system(size: 15))
                    .frame(minWidth: 0, maxWidth: 310, alignment: .leading).fixedSize(horizontal: true, vertical: true)
            }
            
        }
        .frame(minWidth: 310, maxWidth: 310, alignment: .leading)

    }
}

struct SelectSubjectRow_Previews: PreviewProvider {
    static var previews: some View {
        SelectSubjectRow(subjectCell: Subject(id:"123", name: "Introdution to Software Engineer", code: "01418471-60")).environmentObject(SelectSubjectViewModel())
    }
}
