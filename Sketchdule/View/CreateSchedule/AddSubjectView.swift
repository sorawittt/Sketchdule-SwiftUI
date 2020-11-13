import SwiftUI

struct AddSubjectView: View {
    @EnvironmentObject var selectSubject: SelectSubjectViewModel
    @ObservedObject var subjects = AddSubjectViewModel()
    
    var body: some View {
        
        if selectSubject.selectSubject.count > 9 {
            VStack {
                Text("ไม่สามารถเพิ่มวิชาเรียนได้")
                Text("เนื่องจากเลือกถึงจำนวนสูงสุดแล้ว (10 วิชา)")
            }.font(.system(size:16))
        } else {
            VStack() {
                Text("ค้นหาวิชาเรียน")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                SearchBar(text: $subjects.searchCode)
                
                List {
                    if subjects.searchCode.count > 5 {
                        ForEach(subjects.subjectMatchSeacrhCode()) { s in
                            SearchSubjectRow(subjectCell: s)
                        }
                    }
                }
            }.padding(.top)
            .navigationBarTitle("ค้นหาวิชาเรียน")
        }
    }
    
}

struct AddSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjectView().environmentObject(SelectSubjectViewModel())
    }
}

