import SwiftUI

struct Login: View {
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height

    @ObservedObject var loginVM = LoginViewModel.shared
    
    @State private var secured = true
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Username")) {
                    TextField("Username", text: $loginVM.username).font(.system(size: 17))
                    }
                        
                Section(header: Text("Password")) {
                        HStack {
                            if secured {
                                SecureField("Password", text: $loginVM.pw)
                                    .font(.system(size: 17))
                            } else {
                                TextField("Password", text: $loginVM.pw)
                                    .font(.system(size: 17))
                            }
                            Button(action: {
                                secured.toggle()
                            }) {
                                if secured {
                                    Image(systemName: "eye")
                                } else {
                                    Image(systemName: "eye.slash")
                                }
                            }
                        }
                    }
                Section(header: Text(loginVM.loginError).foregroundColor(Color(UIColor.systemRed)),footer:NavigationLink(destination: StudentDetail()) {
                        Text("ไม่มีบัญชีผู้ใช้ ?")
                            .font(.system(size: 15))
                        Text("สร้างบัญชี")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 15))
                    }.padding(.leading, width * 0.22)
                    .padding(.top, height *  0.05)) {
                        Button(action: {
                            loginVM.login()
                        }) {
                            Text("เข้าสู่ระบบ")
                                .font(.system(size: 17))
                                .foregroundColor(Color(UIColor.systemBlue))
                        }.disabled((loginVM.username == "" && loginVM.pw == ""))
                    }
                }.navigationBarTitle("เข้าสู่ระบบ")
                
                        
            }
            
        }
    }



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
