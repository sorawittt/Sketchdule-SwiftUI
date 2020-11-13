import SwiftUI

struct Login: View {
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    @State private var email = ""
    @State private var pw = ""
    
    @State private var secured = true
    
    var body: some View {
        NavigationView {
            VStack() {
                Text("เข้าสู่ระบบ")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.bottom, 20)
                TextField("Email", text: $email)
                    .padding()
                    .frame(width: width * 0.9)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                        
                HStack {
                    if secured {
                        SecureField("Password", text: $pw)
                    } else {
                        TextField("Password", text: $pw)
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
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                .frame(width: width * 0.9)
                .padding(.top, 4)
                
                HStack {
                    Text("ไม่มีบัญชีผู้ใช้ ? ")
                    NavigationLink(destination: Register()) {
                       Text("สร้างบัญชี")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                }.padding(.top, 10).font(.system(size: 16))
                
                Button(action: {
                    
                }) {
                    Text("เข้าสู่ระบบ")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(width: width * 0.9)
                .background(Color(UIColor.systemBlue))
                .cornerRadius(4.0)
                .frame(width: width * 0.9)
                .padding(.top, height * 0.02)
                        
            }.navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
