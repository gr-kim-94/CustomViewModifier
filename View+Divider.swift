//
//  View+Divider.swift
//
//  Created by gr-kim-94 on 2023/05/04.
//

import SwiftUI

struct DividerView: ViewModifier {
    
    var edges: Edge.Set
    var length: CGFloat
    var color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            switch edges {
            case .top:
                topDivider
            case .bottom:
                bottomDivider
            case .leading:
                leadingDivider
            case .trailing:
                trailingDivider
            case .horizontal:
                ZStack {
                    leadingDivider
                    trailingDivider
                }
            case .vertical:
                ZStack {
                    topDivider
                    bottomDivider
                }
            case .all:
                ZStack {
                    topDivider
                    bottomDivider
                    leadingDivider
                    trailingDivider
                }
            default:
                EmptyView()
            }
        }
    }
    
    @ViewBuilder
    private var topDivider: some View {
        VStack(spacing: 0) {
            Divider()
                .backgroundImage(color: color)
                .frame(height: length)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var bottomDivider: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Divider()
                .backgroundImage(color: color)
                .frame(height: length)
        }
    }
    
    @ViewBuilder
    private var leadingDivider: some View {
        HStack(spacing: 0) {
            Divider()
                .backgroundImage(color: color)
                .frame(width: length)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var trailingDivider: some View {
        HStack(spacing: 0) {
            Spacer()
            
            Divider()
                .backgroundImage(color: color)
                .frame(width: length)
        }
    }
}

extension View {
    func divider(_ edges: Edge.Set = .all, _ length: CGFloat = 1, _ color: Color = .blue) -> some View {
        modifier(DividerView(edges: edges, length: length, color: color))
    }
}
