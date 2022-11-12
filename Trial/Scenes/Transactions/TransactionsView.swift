//
//  TransactionsView.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import SwiftUI

struct TransactionsView: View, OnEventProtocol {
    @ObservedObject var viewModel: TransactionsViewModel

    enum Event {

    }

    var onEvent: (Event) -> Void

    init(viewModel: TransactionsViewModel, onEvent: @escaping (Event) -> Void) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.onEvent = onEvent
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                if #available(iOS 14.0, *) {
                    ProgressView()
                } else {
                    #warning("TODO")
                    EmptyView()
                }
            case .ready(let items):
                List(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .foregroundColor(Color.primary)

                            if let subtitle = item.subtitle {
                                Text(subtitle)
                                    .foregroundColor(Color.secondary)
                            }

                            if !item.additionalTexts.isEmpty {
                                Spacer(minLength: 24)

                                ForEach(item.additionalTexts, id: \.self) { line in
                                    Text(line)
                                        .foregroundColor(Color.secondary)
                                }
                            }
                        }
                    }
                }
            case .failed(let error):
                VStack(spacing: 24) {
                    Text(error.localizedDescription)

                    Button(action: {
                        viewModel.loadData()
                    }, label: {
                        Text("Retry")
                    })
                }
            case .none:
                EmptyView()
            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(viewModel: TransactionsViewModel(), onEvent: { _ in })
    }
}
