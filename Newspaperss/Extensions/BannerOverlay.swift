//
//  BannerOverlay.swift
//  Newspaperss
//
//  Created by Mark Cornelisse on 31/07/2023.
//

import SwiftUI

// The contents of this file make sure the AdBanner at the top is inserted at the top with some clean code in the View itself. It makes stuff a lot easier.

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
    
    func topSafeAreaInset<OverlayContent: View>(_ overlayContent: OverlayContent) -> some View {
        modifier(TopInsetViewModifier(overlayContent: overlayContent))
    }
}

@available(iOS, introduced: 13.0, obsoleted: 15.0, message: "iOS 15 introduces func safeAreaInset<V>(edge: VerticalEdge, alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> V) -> some View where V : View")
private struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

@available(iOS, introduced: 13.0, obsoleted: 15.0, message: "iOS 15 introduces func safeAreaInset<V>(edge: VerticalEdge, alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> V) -> some View where V : View")
struct TopInsetViewModifier<OverlayContent: View>: ViewModifier {
    @Environment(\.topSafeAreaInset) var ancestorTopSafeAreaInset: CGFloat
    var overlayContent: OverlayContent
    @State var overlayContentHeight: CGFloat = 0
    
    func body(content: Self.Content) -> some View {
        content
            .environment(\.topSafeAreaInset, overlayContentHeight + ancestorTopSafeAreaInset)
            .overlay(
                overlayContent
                    .readHeight {
                        overlayContentHeight = $0
                    }
                    .padding(.top, ancestorTopSafeAreaInset)
                ,
                alignment: .top
            )
    }
}

@available(iOS, introduced: 13.0, obsoleted: 15.0, message: "iOS 15 introduces func safeAreaInset<V>(edge: VerticalEdge, alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> V) -> some View where V : View")
struct TopSafeAreaInsetKey: EnvironmentKey {
    static var defaultValue: CGFloat = 0
}

@available(iOS, introduced: 13.0, obsoleted: 15.0, message: "iOS 15 introduces func safeAreaInset<V>(edge: VerticalEdge, alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> V) -> some View where V : View")
extension EnvironmentValues {
    var topSafeAreaInset: CGFloat {
        get { self[TopSafeAreaInsetKey.self] }
        set { self[TopSafeAreaInsetKey.self] = newValue }
    }
}

@available(iOS, introduced: 13.0, obsoleted: 15.0, message: "iOS 15 introduces func safeAreaInset<V>(edge: VerticalEdge, alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> V) -> some View where V : View")
struct ExtraTopSafeAreaInset: View {
    @Environment(\.topSafeAreaInset) var topSafeAreaInset: CGFloat
    
    var body: some View {
        Spacer(minLength: topSafeAreaInset)
    }
}
