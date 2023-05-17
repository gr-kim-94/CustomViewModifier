//
//  View + ContentAlertView.swift
//
//  Created by gr-kim-94 on 2023/05/17.
//

import SwiftUI

struct ContentAlertView<ContentAlert: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    @ViewBuilder var alertView: () -> ContentAlert

    func body(content: Content) -> some View {
        return content
            .onChange(of: isPresented) { newValue in
                if let topVC = UIApplication.shared.getKeyWindow?.rootViewController {
                    if newValue {
                        let vc = UIHostingController(rootView: alertView())
                        vc.modalTransitionStyle = .crossDissolve
                        vc.modalPresentationStyle = .overCurrentContext
                        vc.view.backgroundColor = .clear
                        vc.definesPresentationContext = true

                        topVC.present(vc, animated: true)
                    } else {
                        topVC.dismiss(animated: true)
                    }
                }
            }
    }
}

extension View {
    func alertView<ContentAlert: View>(_ isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> ContentAlert) -> some View {
        modifier(ContentAlertView(isPresented: isPresented, alertView: content))
    }
}
