# JustCircleCIRxSwift

### View
描画処理
イベントをViewModelに伝達する
ユーザー操作の受付、画面表示のみを担当、タップやスワイプなどのUIイベントを受付Presenterに処理を委譲

### Model
 UIに関係しない純粋なドメインロジックで単体でテストができる状態
protocolを準拠する形で実装し、テスト時にテスト用のモデルと切り替えられるようにする

### ViewModel
ViewとModelの仲介役、Modelの処理結果をViewで表示しやすい形に形成しデータを渡す.
(viewの参照は保持しない)





