import SwiftUI

struct Register: View {
    @State var id = ""
    @State var showResult = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("รหัสนิสิต")) {
                    HStack {
                        TextField("รหัสนิสิต", text: $id).font(.system(size: 17)).keyboardType(.numberPad)
                        
                        if (id.count == 10) {
                            Button(action: {
                                
                            }) {
                                Image(systemName: "magnifyingglass.circle.fill")
                            }
                        }
                    }
                }
                
                Section(header: Text("ผลการค้นหา")) {
                    HStack {
                        Text("ชื่อ")
                        Spacer()
                        Text("ชื่อ")
                    }.font(.system(size: 17))
                    HStack {
                        Text("นามสกุล")
                        Spacer()
                        Text("นามสกุล")
                    }.font(.system(size: 17))
                    HStack {
                        Text("คณะ")
                        Spacer()
                        Text("คณะ")
                    }.font(.system(size: 17))
                    HStack {
                        Text("สาขา")
                        Spacer()
                        Text("สาขา")
                    }.font(.system(size: 17))
                }
                
                Section {
                    Button(action: {
                        
                    }) {
                        Text("ต่อไป")
                    }
                }
            }
            .navigationTitle("สร้างบัญชี")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
