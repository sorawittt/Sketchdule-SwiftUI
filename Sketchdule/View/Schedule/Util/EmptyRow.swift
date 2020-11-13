import SwiftUI

struct EmptyRow: View {
    private let width = UIScreen.main.bounds.width
    
    var body: some View {
        Text("ไม่มีวิชาเรียน")
            .font(.system(size: 18))
            .frame(width: width * 0.9, height: 50, alignment: .center)
            .padding(10)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(10)
    }
}

struct EmptyRow_Previews: PreviewProvider {
    static var previews: some View {
        EmptyRow()
    }
}
