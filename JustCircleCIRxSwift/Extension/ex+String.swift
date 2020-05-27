//
//  ex+String.swift
//  JustCircleCIRxSwift
//
//  Created by Yamamoto Kazunori on 2020/05/28.
//  Copyright © 2020 BBO. All rights reserved.
//

import Foundation

extension String: ExtensionCompatible { }
extension Extension where Base == String {
    public var plzInsertText: String {
        return "IDとPasswordを入力してください"
    }
}
