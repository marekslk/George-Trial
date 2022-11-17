//
//  TransactionDetail.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import SwiftUI
import TrialCore

public struct TransactionDetailView: View, OnEventProtocol {
    @ObservedObject var viewModel: TransactionDetailViewModel

    public enum Event {
    }

    public var onEvent: (Event) -> Void

    public init(viewModel: TransactionDetailViewModel, onEvent: @escaping (Event) -> Void) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
        self.onEvent = onEvent
    }

    // MARK: body
    public var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                if #available(iOS 14.0, *) {
                    ProgressView()
                } else {
                    Text("loading".localized(bundle: .module))
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
                        Text("retry".localized(bundle: .module))
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
