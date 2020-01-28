//
//  JustCircleCIRxSwiftTests.swift
//  JustCircleCIRxSwiftTests
//
//  Created by 山本一範 on 2019/10/09.
//  Copyright © 2019. All rights reserved.
//

import XCTest
import RxSwift
@testable import JustCircleCIRxSwift

class FakeModel: ModelProtocol {

    var result: Observable<Void>?
    
    func validate(id: String, password: String) -> Observable<Void> {
        guard let result = result else {
            fatalError("")
        }
        return result
    }
}

// enum ModelError: Error
//    case invalidId
//    case invalidPassword
//    case invalidIdAndPassword
// ↑このパターンを網羅的にテストを書くのがベスト(大変な場合は閾値や大小ケース)
class ViewModelTests: XCTestCase {
    let model = FakeModel() // テストモデル
    /// let model = Model() ＜ー　一行変更すれば実際のモデルでテスト

    override func setUp() {
        super.setUp()
        
    }
    
    func test_SuccessCase() {
        let idTextObservable = Observable<String>.create { observer -> Disposable in
            observer.onNext("id")
            observer.onCompleted()
            return Disposables.create()
        }
        
        let passwordTextObservable = Observable<String>.create { observer -> Disposable in
            observer.onNext("password")
            return Disposables.create()
        }
        model.result = Observable.just(())
        
        let viewModel = ViewModel(
            idTextObservable: idTextObservable,
            passwordTextObservable: passwordTextObservable,
            model: model)
        
        viewModel.validationText.subscribe { text in
            XCTAssertEqual("OK.", text.element)
        }
        .dispose()
        
        viewModel.loadLabelColor.subscribe { color in
            XCTAssertEqual(UIColor.green, color.element)
        }
        .dispose()
        
    }
    
    func test_invalidIdCase() {
        let idTextObservable = Observable<String>.create { observer -> Disposable in
            observer.onNext("")
            return Disposables.create()
        }
        
        let passwordTextObservable = Observable<String>.create { observer -> Disposable in
            observer.onNext("password")
            observer.onCompleted()
            return Disposables.create()
        }
        
        let viewModel = ViewModel(
        idTextObservable: idTextObservable,
        passwordTextObservable: passwordTextObservable,
        model: model)
        
        /// invalidIdCase
        model.result = Observable.error(ModelError.invalidId)
        
        viewModel.validationText.subscribe { text in
            XCTAssertEqual("IDが未入力です。", text.element)
        }
        .dispose()
        
        viewModel.loadLabelColor.subscribe { color in
            XCTAssertEqual(UIColor.red, color.element)
        }
        .dispose()
    }
    
    func test_invalidPassword() {
        let idTextObservable = Observable<String>.create { observer -> Disposable in
            observer.onNext("id")
            return Disposables.create()
        }
        
        let passwordTextObservable = Observable<String>.create { observer -> Disposable in
            observer.onNext("")
            observer.onCompleted()
            return Disposables.create()
        }
        
        let viewModel = ViewModel(
        idTextObservable: idTextObservable,
        passwordTextObservable: passwordTextObservable,
        model: model)
        
        /// invalidIdCase
        model.result = Observable.error(ModelError.invalidPassword)
        
        viewModel.validationText.subscribe { text in
            XCTAssertEqual("Passwordが未入力です。", text.element)
        }
        .dispose()
        
        viewModel.loadLabelColor.subscribe { color in
            XCTAssertEqual(UIColor.red, color.element)
        }
        .dispose()
    }
    
    
}
