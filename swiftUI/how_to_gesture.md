# how_to_gesture

[［改訂第3版］Swiftポケットリファレンス](https://gihyo.jp/book/2024/978-4-297-14190-5)の「Chapter8 画面の操作を処理する」を参考にジェスチャーを理解する

## ジェスチャを登録する、n回タップを検知する

### View

```Swift
import SwiftUI

struct DoubleTapView: View {
    @State private var isdoubleTapped = false

    var body: some View {
        VStack {
            Text("Double Tap")
                .font(.headline)

            Circle()
                .frame(width: 100)
                .foregroundStyle(isdoubleTapped ? .red : .blue)
                .gesture( // TapGestureを登録
                    TapGesture(count: 2) // countパラメータのデフォルトはシングルタップ
                        .onEnded { _ in
                            isdoubleTapped.toggle()
                        }
                )

            Text("Tap Here!")
        }
    }
}
```

## メモ
