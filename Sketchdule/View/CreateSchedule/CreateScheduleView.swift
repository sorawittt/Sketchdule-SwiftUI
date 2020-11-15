import SwiftUI

struct CreateScheduleView: View {
    @State var showingSheet = false
    @ObservedObject var selectSubjectVM = SelectSubjectViewModel.shared
    @State private var isEditable = false
    @State private var buttonDisable = true
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView {
            VStack() {
                List {
                    ForEach(selectSubjectVM.selectSubject) { s in
                        SelectSubjectRow(subjectCell: s)
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                }
                NavigationLink(destination: SelectScheduleView(), tag: 1, selection: $action) {EmptyView()}
                Button(action: {
                    emptrySelect()
                    self.action = 1
                }) {
                    Text("สร้างตารางเรียน").font(.system(size: 15)).foregroundColor(.white)
                        .frame(minWidth: 330, maxWidth: 330, minHeight: 25, maxHeight: 25)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(!(selectSubjectVM.selectSubject.count > 0))
            }.environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
            .navigationBarTitle("สร้างตารางเรียน")
            .navigationBarItems(leading:
                Button(action: {
                    self.isEditable.toggle()
                }) {
                    if isEditable {
                        Text("เสร็จสิ้น")
                    } else {
                        Text("แก้ไข")
                    }
            },trailing:
                Button(action: {
                    self.showingSheet.toggle()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 24.0, height: 24.0)
                }.sheet(isPresented: $showingSheet) {
                    AddSubjectView()
                }
            )
        }
        
    }
    
    
    private func move(from source: IndexSet, to destination: Int) {
        selectSubjectVM.selectSubject.move(fromOffsets: source, toOffset: destination)
    }
    
    private func delete(at offset: IndexSet) {
        selectSubjectVM.selectSubject.remove(atOffsets: offset)
    }
    
    private func emptrySelect() {
        selectSubjectVM.emptrySelectSubject()
    }
}

struct CreateScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        CreateScheduleView()
    }
}
