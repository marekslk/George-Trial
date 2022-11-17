//
//  ViewModelingState.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

public enum ViewModelingState<T> {
    case loading
    case ready(value: T)
    case failed(error: Error)
}
