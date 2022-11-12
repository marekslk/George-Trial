//
//  OnboardingView.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import SwiftUI

struct OnboardingView: View, OnEventProtocol {
    enum Event {
        case dismiss
    }

    var onEvent: (Event) -> Void

    var body: some View {
        VStack {
            Text("Hey")
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
