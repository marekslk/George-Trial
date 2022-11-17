//
//  TransactionsView.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import SwiftUI
import TrialCore

public struct TransactionsView: View, OnEventProtocol {
    @ObservedObject var viewModel: TransactionsViewModel

    // MARK: Data
    public struct Data {
        let transactionsCount: Int
        let balanceFormatted: String
        let items: [TransactionRowItem]
    }

    // MARK: Event
    public enum Event {
        case detail(TransactionRowItem)
    }

    public var onEvent: (Event) -> Void

    public init(viewModel: TransactionsViewModel, onEvent: @escaping (Event) -> Void) {
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
                    Text("loading")//.localized)
                }

            case .ready(let data):
                ScrollView {
                    Group {
                        VStack {
                            balance(balanceFormatted: data.balanceFormatted)

                            transactionsInfo(transactionsCount: data.transactionsCount)
                        }

                        // We can't use LazyVStack for older iOS & List component doesn't provide good UI.
                        if #available(iOS 14.0, *) {
                            LazyVStack(alignment: .leading) {
                                ForEach(data.items) { item in
                                    transactionItem(item)
                                }
                            }
                        } else {
                            VStack(alignment: .leading) {
                                ForEach(data.items) { item in
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
                        .multilineTextAlignment(.center)

                    Button(action: {
                        viewModel.loadData()
                    }, label: {
                        Text("retry")//.localized)
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

private extension TransactionsView {
    // MARK: balance
    @ViewBuilder
    func balance(balanceFormatted: String) -> some View {
        HStack {
//            Text("\("transactions.balance".localized) \(balanceFormatted)")
            Text("transactions.balance \(balanceFormatted)")
                .foregroundColor(Color.primary)
                .bold()

            Spacer()
        }
    }

    // MARK: balance
    @ViewBuilder
    func transactionsInfo(transactionsCount: Int) -> some View {
        HStack {
            Text("transactions.count")//.localized)
                .foregroundColor(Color.primary)
                .bold()

            Text("\(transactionsCount)")
                .foregroundColor(Color.primary)
                .bold()

            Spacer()
        }
        .padding(.top, 6)
        .padding(.bottom, 12)
    }

    // MARK: transactionItem
    @ViewBuilder
    private func transactionItem(_ model: TransactionRowItem) -> some View {
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
