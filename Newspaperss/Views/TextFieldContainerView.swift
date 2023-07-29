//
//  TextFieldContainerView.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 29/07/2023.
//

import SwiftUI

struct TextFieldContainerView: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Enter RSS URL", text: $text)
            .padding()
    }
}

struct TextFieldContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldContainerView(text: .constant("Bazinga"))
    }
}
