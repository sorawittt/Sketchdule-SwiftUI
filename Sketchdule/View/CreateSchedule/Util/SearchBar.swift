import SwiftUI
 
struct SearchBar: View {
    
    @Binding var text: String
 
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.secondary)
            TextField("รหัสวิชา", text: $text)
                .font(Font.system(size: 16))
            if self.text != "" {
                Image(systemName: "xmark.circle.fill")
                    .imageScale(.medium)
                    .foregroundColor(Color(.systemGray3))
                    .padding(3)
                    .onTapGesture {
                        withAnimation {
                            self.text = ""
                        }
                }
            }
        }
        .padding(7)
        .padding(.horizontal, 25)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal, 10)
    }
    
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
