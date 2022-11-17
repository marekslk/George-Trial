//
//  OnboardingView.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import SwiftUI
import TrialCore

public struct OnboardingView: View, OnEventProtocol {
    public enum Event {
        case dismiss
    }

    public var onEvent: (Event) -> Void

    public init(onEvent: @escaping (Event) -> Void) {
        self.onEvent = onEvent
    }

    public var body: some View {
        VStack {
            Text("👋")
        }
        .navigationBarItems(trailing: closeButton)
    }

    private var closeButton: some View {
        Button(action: {
            onEvent(.dismiss)
        }) {
            Image(systemName: "xmark")
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onEvent: { _ in })
    }
}
