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
                    Text("loading".localized)
                }

            case .ready(let items):
                ScrollView {
                    HStack {
                        Text("transactions.count".localized)
                            .foregroundColor(Color.primary)
                            .bold()

                        Text("\(items.count)")
                            .foregroundColor(Color.primary)
                            .bold()
                            .italic()

                        Spacer()
                    }
                    .padding(.bottom, 12)

                    if #available(iOS 14.0, *) {
                        LazyVStack(alignment: .leading) {
                            ForEach(items) { item in
                                transactionItem(item)
                            }
                        }
                    } else {
                        VStack(alignment: .leading) {
                            ForEach(items) { item in
                                transactionItem(item)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)

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
        .onAppear {
            viewModel.loadData()
        }
    }

    @ViewBuilder
    private func transactionItem(_ model: TransactionItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(model.title)
                        .font(.body)
                        .foregroundColor(Color.primary)

                    Spacer()
                    
                    Text(model.amountFormatted)
                        .font(.body)
                        .bold()
                        .foregroundColor(Color.primary)
                }

                if let subtitle = model.subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(Color.secondary)
                }

                if !model.additionalTexts.isEmpty {
                    Spacer()
                        .frame(height: 12)

                    ForEach(model.additionalTexts, id: \.self) { line in
                        Text(line)
                            .font(.caption)
                            .foregroundColor(Color.secondary.opacity(0.8))
                    }
                }

                Divider()
                    .padding(.vertical, 12)
            }
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(viewModel: TransactionsViewModel(), onEvent: { _ in })
    }
}
