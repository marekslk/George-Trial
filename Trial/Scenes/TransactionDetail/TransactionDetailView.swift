//
//  TransactionDetail.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import SwiftUI

struct TransactionDetailView: View, OnEventProtocol {
    @ObservedObject var viewModel: TransactionDetailViewModel

    enum Event {
    }

    var onEvent: (Event) -> Void

    init(viewModel: TransactionDetailViewModel, onEvent: @escaping (Event) -> Void) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.onEvent = onEvent
    }

    // MARK: body
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                if #available(iOS 14.0, *) {
                    ProgressView()
                } else {
                    Text("loading".localized)
                }

            case .ready(let item):
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .foregroundColor(Color.primary)
                            .bold()

                        if let subtitle = item.subtitle {
                            Text("\(subtitle)")
                                .foregroundColor(Color.primary)
                        }

                        Spacer()
                    }

                    Spacer()
                }
            case .failed(let error):
                VStack(spacing: 24) {
                    Text(error.localizedDescription)

                    Button(action: {
                        viewModel.loadData()
                    }, label: {
                        Text("retry".localized)
                    })
                }

            case .none:
                EmptyView()
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.loadData()
        }
    }
}
