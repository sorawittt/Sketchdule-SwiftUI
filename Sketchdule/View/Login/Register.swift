import SwiftUI
import ToastUI

struct Register: View {
    @State var id = ""
    @State var username = ""
    @State var pw = ""
    @State var confirmPW = ""
    @ObservedObject var regisVM = RegisterViewModel.shared
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            Form {
                Section(header: Text("รหัสนิสิต")) {
                    HStack {
                        TextField(regisVM.studentID, text: $regisVM.studentID).font(.system(size: 17)).keyboardType(.numberPad)
                        }
                }.disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                Section(header: Text("Username"), footer: Text(regisVM.errorUsername).foregroundColor(.red)) {
                    TextField("Username", text: $regisVM.username)
                    .font(.system(size: 17))
                }
                
                Section(header: Text("Password"), footer: Text(regisVM.errorPW).foregroundColor(.red)) {
                    SecureField("Password", text: $regisVM.pw)
                        .font(.system(size: 17))
                    SecureField("Confirm Password", text: $regisVM.confirmPW)
                        .font(.system(size: 17))
                }
                
                Section {
                    Button(action: {
                        regisVM.signup()
                    }) {
                        Text("สร้างบัญชีผู้ใช้")
                            .foregroundColor(Color(UIColor.systemBlue))
                            .font(.system(size: 17))
                    }
                    .disabled(!(regisVM.errorPW == "" && regisVM.errorUsername == ""))
                    
                    .toast(isPresented: $regisVM.showAlert) {
                            if regisVM.status != "" {
                                if regisVM.status == "400" {
                                    ToastView {
                                        VStack {
                                            Image(systemName: "info.circle.fill")
                                                .renderingMode(.template)
                                                .foregroundColor(Color(UIColor.systemYellow))
                                                .font(.system(size: 60))
                                            
                                            Text("Username ซ้ำ")
                                                .padding(10)
                                                .multilineTextAlignment(.center)
                                            
                                            Button(action: {
                                                regisVM.showAlert = false
                                            }) {
                                                Text("ตกลง")
                                            }
                                        }
                                    }
                                } else {
                                    VStack {
                                        Image(systemName: "xmark.octagon.fill")
                                            .renderingMode(.template)
                                            .foregroundColor(Color(UIColor.systemRed))
                                            .font(.system(size: 60))
                                        
                                        Text("มีข้อผิดพลาด กรุณาลองอีกครั้งภายหลัง")
                                            .padding(10)
                                            .multilineTextAlignment(.center)
                                        
                                        Button(action: {
                                            regisVM.showAlert = false
                                        }) {
                                            Text("ตกลง")
                                        }
                                    }
                                }
                            } else {
                                ToastView {
                                    VStack {
                                        Image(systemName: "checkmark.circle.fill")
                                            .renderingMode(.template)
                                            .foregroundColor(Color(UIColor.systemGreen))
                                            .font(.system(size: 60))
                                        
                                        Text("สร้างบัญชีผู้ใช้สำเร็จ")
                                            .padding(10)
                                            .multilineTextAlignment(.center)
                                        
                                        Button(action: {
                                            regisVM.reset()
                                            presentationMode.wrappedValue.dismiss()
                                            regisVM.showAlert = false
                                        }) {
                                            Text("ตกลง")
                                        }
                                    }
                                }
                            }
                        }
                          
            }
            .navigationTitle("สร้างบัญชี")
        }
    }
}
struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
