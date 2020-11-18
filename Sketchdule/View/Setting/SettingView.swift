import SwiftUI
import RealmSwift

struct SettingView: View {
    
    @State var notificationsEnabled: Bool = false
    @State private var showingAlert = false
    
    let userDB = UserDB.shared
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("ข้อมูลผู้ใช้")) {
                    HStack {
                        Text("ชื่อ").font(.system(size: 17))
                        Spacer()
                        Text("\(userDB.firstname)" + " " + "\(userDB.lastname)").font(.system(size: 17))
                    }
                    HStack {
                        Text("รหัสนิสิต").font(.system(size: 17))
                        Spacer()
                        Text("\(userDB.studentId)").font(.system(size: 17))
                    }
                    HStack {
                        Text("คณะ").font(.system(size: 17))
                        Spacer()
                        Text(userDB.faculty).font(.system(size: 17))
                    }
                    HStack {
                        Text("ภาควิชา").font(.system(size: 17))
                        Spacer()
                        Text(userDB.major).font(.system(size: 17))
                    }
                    HStack {
                        Text("รหัสสาขา").font(.system(size: 17))
                        Spacer()
                        Text(userDB.majorCode).font(.system(size: 17))
                    }
                }
                
//                Section(header: Text("การแจ้งเตือน")) {
//                    Toggle(isOn: $notificationsEnabled) {
//                            Text("แจ้งเตือนก่อนถึงเวลาเรียน").font(.system(size: 17))
//                    }
//                }
                
//                Section {
//                    Button(action: {
//                       
//                    }) {
//                        Text("ลบข้อมูลตารางเรียน").foregroundColor(Color(UIColor.systemRed))
//                            .font(.system(size: 17))
//                    }
//                    .alert(isPresented:$showingAlert) {
//                        Alert(title: Text("ยืนยัน"), message: Text("ลบข้อมูลตารางเรียน"), primaryButton: .default(Text("ยืนยัน")) {
//                                DB().deleteAllSchedule()
//                        }, secondaryButton: .cancel(Text("ยกเลิก")))
//                    }
//                }
                
                Section {
                    Button(action: {
                        userDB.logout()
                    }) {
                        Text("ออกจากระบบ").foregroundColor(Color(UIColor.systemRed))
                            .font(.system(size: 17))
                        }
                }
            }
            .navigationBarTitle("ตั้งค่า")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
