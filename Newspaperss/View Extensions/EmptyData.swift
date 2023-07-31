//
//  EmptyData.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 31/07/2023.
//

import SwiftUI

extension View {
    func emptyListPlaceHolder<V: Collection, Content: View>(_ data: Binding<V>, @ViewBuilder placeHolderContent: @escaping () -> Content) -> some View {
        return self.modifier(EmptyListPlaceHolderViewModifier(data: data, placeHolderContent: placeHolderContent))
    }
}

struct EmptyListPlaceHolderViewModifier<V: Collection, P: View>: ViewModifier {
    @Binding var data: V
    
    @ViewBuilder var placeHolderContent: () -> P
    
    func body(content: Content) -> some View {
        if data.isEmpty {
            placeHolderContent()
        } else {
            content
        }
    }
}
