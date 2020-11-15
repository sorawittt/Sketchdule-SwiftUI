import SwiftUI

struct StudentDetail: View {
    @State var showResult = false
    @ObservedObject var regisVM = RegisterViewModel.shared
    
    var body: some View {
            Form {
                Section(header: Text("รหัสนิสิต")) {
                    HStack {
                        TextField("รหัสนิสิต", text: $regisVM.studentID).font(.system(size: 17)).keyboardType(.numberPad)
                        
                        if (regisVM.studentID.count == 10) {
                            Button(action: {
                                regisVM.getDetail()
                            }) {
                                Image(systemName: "magnifyingglass.circle.fill")
                            }
                        }
                    }
                }
                
                Section(header: Text("ผลการค้นหา")) {
                    HStack {
                        Text("ชื่อ").foregroundColor(Color(UIColor.systemGray2))
                        Spacer()
                        Text(regisVM.currentStudent.firstname)
                    }.font(.system(size: 17))
                    HStack {
                        Text("นามสกุล").foregroundColor(Color(UIColor.systemGray2))
                        Spacer()
                        Text(regisVM.currentStudent.lastname)
                    }.font(.system(size: 17))
                    HStack {
                        Text("คณะ").foregroundColor(Color(UIColor.systemGray2))
                        Spacer()
                        Text(regisVM.currentStudent.faculty)
                    }.font(.system(size: 17))
                    HStack {
                        Text("สาขา").foregroundColor(Color(UIColor.systemGray2))
                        Spacer()
                        Text(regisVM.currentStudent.major)
                    }.font(.system(size: 17))
                    HStack {
                        Text("รหัสสาขา").foregroundColor(Color(UIColor.systemGray2))
                        Spacer()
                        Text(regisVM.currentStudent.majorCode)
                    }.font(.system(size: 17))
                }
                
                Section {
                    NavigationLink(destination: Register()) {
                        Text("ต่อไป")
                            .font(.system(size: 17))
                            .foregroundColor(Color(UIColor.systemBlue))
                    }
                    .disabled(!regisVM.canContinue)
                }
            }
            .navigationTitle("ตรวจสอบข้อมูล")
        }
    }


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        StudentDetail()
    }
}
