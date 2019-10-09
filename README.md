# JustCircleCIRxSwift


## MVVM (RxSwift)

### View

https://github.com/kazTera/JustCircleCIRxSwift/blob/master/JustCircleCIRxSwift/JustCircleCIRxSwift/ViewController.swift

描画処理
イベントをViewModelに伝達する
ユーザー操作の受付、画面表示のみを担当、タップやスワイプなどのUIイベントを受付Presenterに処理を委譲

### Model

https://github.com/kazTera/JustCircleCIRxSwift/blob/master/JustCircleCIRxSwift/JustCircleCIRxSwift/Model.swift

 UIに関係しない純粋なドメインロジックで単体でテストができる状態
protocolを準拠する形で実装し、テスト時にテスト用のモデルと切り替えられるようにする

### ViewModel

https://github.com/kazTera/JustCircleCIRxSwift/blob/master/JustCircleCIRxSwift/JustCircleCIRxSwift/ViewModel.swift

ViewとModelの仲介役、Modelの処理結果をViewで表示しやすい形に形成しデータを渡す.
(viewの参照は保持しない)



## Test code

https://github.com/kazTera/JustCircleCIRxSwift/blob/master/JustCircleCIRxSwift/JustCircleCIRxSwiftTests/JustCircleCIRxSwiftTests.swift

Errorケース、successケースを網羅的にテストを記述する
ケースが多すぎる場合は、閾値になるケース、大小ケースをテストすれば良さそうです。





