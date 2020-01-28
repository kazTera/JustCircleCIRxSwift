//
//  Model.swift
//  JustCircleCIRxSwift
//
//  Created by 山本一範 on 2019/10/09.
//  Copyright © 2019. All rights reserved.
//
import RxSwift

enum ModelError: Error {
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
}

protocol ModelProtocol {
    func validate(id: String,
                  password: String) -> Observable<Void>
}

final class Model: ModelProtocol {
    func validate(id: String, password: String) -> Observable<Void> {
        switch (id.isEmpty, password.isEmpty) {
        case (true, true):
            return Observable.error(ModelError.invalidIdAndPassword)
        case (true, false):
            return Observable.error(ModelError.invalidId)
        case (false, true):
            return Observable.error(ModelError.invalidPassword)
        case (false, false):
            return Observable.just(())
        }
    }
}
