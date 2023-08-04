//
//  EmptyData.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 31/07/2023.
//

import SwiftUI
import CoreData

extension View {
    func noDataPlaceHolder<Content: View>(_ isEmpty: Bool, @ViewBuilder placeHolderContent: @escaping () -> Content) -> some View {
        return self.modifier(NoDataPlaceHolderViewModifier(isEmpty: isEmpty, placeHolderContent: placeHolderContent))
    }
}

fileprivate struct NoDataPlaceHolderViewModifier<P: View>: ViewModifier {
    let isEmpty: Bool
    
    @ViewBuilder var placeHolderContent: () -> P
    
    func body(content: Content) -> some View {
        if isEmpty {
            placeHolderContent()
        } else {
            content
        }
    }
}
