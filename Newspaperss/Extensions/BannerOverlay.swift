//
//  BannerOverlay.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 31/07/2023.
//

import SwiftUI

@available(iOS, introduced: 13.0, obsoleted: 15.0, message: "iOS 15 introduces func safeAreaInset<V>(edge: VerticalEdge, alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> V) -> some View where V : View")
extension View {
    func readHeight(onChange: @escaping (CGFloat) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Spacer()
                    .preference(
                        key: HeightPreferenceKey.self,
                        value: geometryProxy.size.height
                    )
            }
        )
        .onPreferenceChange(HeightPreferenceKey.self, perform: onChange)
    }
}

@available(iOS, introduced: 13.0, obsoleted: 15.0, message: "iOS 15 introduces func safeAreaInset<V>(edge: VerticalEdge, alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> V) -> some View where V : View")
private struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}
