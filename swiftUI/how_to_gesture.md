# how_to_gesture

[［改訂第3版］Swiftポケットリファレンス](https://gihyo.jp/book/2024/978-4-297-14190-5)の「Chapter8 画面の操作を処理する」を参考にジェスチャーを理解する

## ジェスチャを登録する、n回タップを検知する

```Swift
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

## ジェスチャー中/終了時の処理を指定

```Swift

```

## メモ

[gesture(_:including:)](https://developer.apple.com/documentation/swiftui/view/gesture(_:including:))

- includingパラメータにGestureMaskオブジェクトのプロパティを指定することで、ジェスチャの検知を無効化したり、ビューに登録したジェスチャは使えるがサブビューのジェスチャを無効化したり、利用シーンに合わせて調整することができる
