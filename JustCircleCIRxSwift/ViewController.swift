//
//  ViewController.swift
//  JustCircleCIRxSwift
//
//  Created by 山本一範 on 2019/10/09.
//  Copyright © 2019. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    
    private lazy var viewModel = ViewModel(
        idTextObservable: idTextField.rx.text.orEmpty.asObservable(),
        passwordTextObservable: passwordTextField.rx.text.orEmpty.asObservable(),
        model: Model())
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.validationText
            .bind(to: validationLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.loadLabelColor
            .bind(to: loadLabelColor)
            .disposed(by: disposeBag)
        
    }
    
    private var loadLabelColor: Binder<UIColor> {
        return Binder(self) { (me, color) in
            me.validationLabel.textColor = color
        }
    }
}

