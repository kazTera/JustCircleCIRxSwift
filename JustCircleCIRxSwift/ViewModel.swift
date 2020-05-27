//
//  ViewModel.swift
//  JustCircleCIRxSwift
//
//  Created by 山本一範 on 2019/10/09.
//  Copyright © 2019. All rights reserved.
//

import Foundation
import RxSwift

final class ViewModel {
    let validationText: Observable<String>
    let loadLabelColor: Observable<UIColor>
    
    /// initに渡すモデルをprotocolに抽象的にしているのは、DI（依存性の注入)でテストモデルを使用しテストを行うため
    ///
    init(idTextObservable: Observable<String>,
         passwordTextObservable: Observable<String>,
         model: ModelProtocol) {
        
        let event = Observable
        .combineLatest(idTextObservable, passwordTextObservable)
        .flatMap { id, pass in
            return model.validate(id: id, password: pass)
                .materialize()
        }
        .skip(1)
        .share()
        
        self.validationText = event.flatMap{ event -> Observable<String> in
            switch event {
            case .next:
                return .just("OK.")
            case let .error(error as ModelError):
                return .just(error.errorText)
            case .error, .completed:
                return .empty()
            }
        }
        .startWith(String().ex.plzInsertText)
        
        self.loadLabelColor = event
            .flatMap{ event -> Observable<UIColor> in
            switch event {
            case .next:
                return .just(.green)
            case .error:
                return .just(.red)
            case .completed:
                return .empty()
            }
        }
        
    }
}

extension ModelError {
    fileprivate var errorText: String {
        switch self {
        case .invalidId:
            return "IDが未入力です。"
        case .invalidPassword:
            return "Passwordが未入力です。"
        case .invalidIdAndPassword:
            return "IDとPasswordが未入力です。"
        }
    }
}
