//
//  EmptyCompareCard.swift
//  Sketchdule
//
//  Created by Sorawit Ruangthong on 23/11/2563 BE.
//

import SwiftUI

struct EmptyCompareCard: View {
    private let width = UIScreen.main.bounds.width
    private let hegiht = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("ไม่มี")
                .font(.system(size: 24))
        }
        .frame(width: width * 0.9, height: hegiht * 0.07)
        .padding(10)
        .background(Color(UIColor.systemGray5))
        .cornerRadius(10)
    }
}

struct EmptyCompareCard_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCompareCard()
    }
}
