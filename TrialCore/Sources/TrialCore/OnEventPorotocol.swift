//
//  OnEventPorotocol.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

public protocol OnEventProtocol {
    associatedtype Event

    var onEvent: (Event) -> Void { get }
}
