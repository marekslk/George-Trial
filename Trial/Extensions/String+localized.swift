//
//  String+localized.swift
//  Trial
//
//  Created by Marek Slávik on 12.11.2022.
//  Copyright © 2022 BeeOne Gmbh. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle(for: AppDelegate.self), comment: "")
    }
}
