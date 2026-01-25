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
struct DragToMoveView: View {
    // DragGestureで得られる移動距離を格納する変数
    @State private var offset: CGSize = CGSizeZero

    var body: some View {
        VStack {
            Text("Drag to move")
                .font(.headline)

            Circle()
                .fill(.red)
                .frame(width: 100, height: 100)
                .offset(offset) // ジェスチャーで処理した値を反映
                .gesture(
                    DragGesture()
                        .onChanged { value in // ジェスチャー中の処理を指定。 Valueはジェスチャーによって変化した値
                            // 移動距離にオフセット値を反映
                            // ドラッグジェスチャの開始からドラッグジェスチャの現在のイベントまでの合計変換（？）
                            // https://developer.apple.com/documentation/swiftui/draggesture/value/translation
                            offset = value.translation
                        }
                        .onEnded { _ in // ジェスチャー終了時の処理を指定
                            withAnimation(.easeInOut) {
                                offset = .zero // 初期位置に戻す
                            }
                        }
                )

            Text("Drag here!")
        }
    }
}
```

## 長押しを利用する

```Swift
struct LongPressView: View {
    // ジェスチャーによる状態の変化を格納する変数
    @GestureState private var isPressed: Bool = false

    var body: some View {
        VStack {
            Text("Long press")
                .font(.headline)

            Circle()
                .frame(width: 100, height: 100)
                .opacity(isPressed ? 0 : 1.0) // gestureの状態によって変化
                .gesture(LongPressGesture(minimumDuration: 1) // longPressGesuteを登録
                    .updating($isPressed) { value, state, transaction in
                        state = value
                        // アニメーションを伴ってクロージャ内の処理を実行
                        transaction.animation = Animation.easeOut(duration: 3.0)
                    }
                )

            Text("Long press here!")
        }

    }
}
```

## メモ

[gesture(_:including:)](https://developer.apple.com/documentation/swiftui/view/gesture(_:including:))

- includingパラメータにGestureMaskオブジェクトのプロパティを指定することで、ジェスチャの検知を無効化したり、ビューに登録したジェスチャは使えるがサブビューのジェスチャを無効化したり、利用シーンに合わせて調整することができる
