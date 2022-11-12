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

    struct Model {
        let transactionsCount: Int
        let transactionsSumFormatted: String
        let items: [TransactionItem]
    }

    enum Event {
        case detail(TransactionItem)
    }

    var onEvent: (Event) -> Void

    init(viewModel: TransactionsViewModel, onEvent: @escaping (Event) -> Void) {
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

            case .ready(let model):
                ScrollView {
                    Group {
                        VStack {
                            HStack {
                                Text("\("transactions.balance".localized) \(model.transactionsSumFormatted)")
                                    .foregroundColor(Color.primary)
                                    .bold()

                                Spacer()
                            }

                            HStack {
                                Text("transactions.count".localized)
                                    .foregroundColor(Color.primary)
                                    .bold()

                                Text("\(model.transactionsCount)")
                                    .foregroundColor(Color.primary)
                                    .bold()

                                Spacer()
                            }
                            .padding(.top, 6)
                            .padding(.bottom, 12)
                        }

                        if #available(iOS 14.0, *) {
                            LazyVStack(alignment: .leading) {
                                ForEach(model.items) { item in
                                    transactionItem(item)
                                }
                            }
                        } else {
                            VStack(alignment: .leading) {
                                ForEach(model.items) { item in
                                    transactionItem(item)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
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
        .onAppear {
            viewModel.loadData()
        }
    }

    // MARK: transactionItem
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
                    .padding(.top, 12)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onEvent(.detail(model))
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(viewModel: TransactionsViewModel(), onEvent: { _ in })
    }
}
