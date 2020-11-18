import SwiftUI

struct SearchSubjectRow: View {
    var subjectCell: Subject
    @ObservedObject var selectSubjectVM = SelectSubjectViewModel.shared
    private let width = UIScreen.main.bounds.width
    
    var body: some View {
        HStack {
            Text("\(subjectCell.code) | \(subjectCell.name)").frame(minWidth: 0, maxWidth: width * 0.81, alignment: .leading).fixedSize(horizontal: true, vertical: true)
            Spacer()
            if selectSubjectVM.isContain(c: subjectCell.code) {
                Image(systemName: "minus.circle.fill").renderingMode(.original).onTapGesture {
                    selectSubjectVM.removeSubject(c: subjectCell.code)
                }
                
            } else {
                Image(systemName: "plus.circle.fill").renderingMode(.original).onTapGesture {
                    selectSubjectVM.addSubject(subject: subjectCell)
                    
                }
            }
        }
        .frame(minWidth: width * 0.9)
        .padding(5)

    }
}

struct SubjectRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchSubjectRow(subjectCell: Subject(id:"123", name: "Introdution to Software Engineer", code: "01418471")).environmentObject(SelectSubjectViewModel())
        }

}
