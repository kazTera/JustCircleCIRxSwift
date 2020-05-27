//
//  Extension.swift
//  JustCircleCIRxSwift
//
//  Created by Yamamoto Kazunori on 2020/05/28.
//  Copyright © 2020 BBO. All rights reserved.
//

import Foundation

/// 拡張する型が準拠するプロトコル
public protocol ExtensionCompatible {
    associatedtype CompatibleType // 具象実装側によりこの型はExtension<Self>になる
    
    var ex: CompatibleType { get }
}

extension ExtensionCompatible {
    public var ex: Extension<Self> {
        return Extension(self)
    }
}

// 拡張したい方をこの型のwhere条件として拡張していく
// f.g
// extension String: ExtensionCompatible {}
// extension Extension where Base == String
public final class Extension<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}
