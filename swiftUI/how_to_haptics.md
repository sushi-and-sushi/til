# how_to_haptics

## とにかく試す

```Swift
struct ContentView: View {
    var body: some View {
        Button("Haptic Button") {
            isActive.toggle()
        }
        .sensoryFeedback(.impact, trigger: isActive)
    }
}
```

## デフォルトのパターン

[SensoryFeedback | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/sensoryfeedback)

iOSのものを確認してみる

### `.alignment`

ドラッグされた要素が配置されたことを伝える

### `.decrease`, `.increase`

重要な値が閾値を下回った・上回ったことを伝える

### `.selection`

UI要素の値が変更されていることを伝える（？）

### `.pathComplete`

描画されたパスが完了および/または認識されたことを伝える（？）
iOSでしか実行できないが、サンプルアプリで動かしてみてもフィードバックは無かった。

### `.success`, `.warning`, `.error`

操作の結果を通知する
OS標準アプリでよく見られるパターン

## カスタムするパターン

どちらも視覚的な体験を補完するために使用できる物理的メタファーを提供する（？）

- [impact(weight:intensity:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(weight:intensity:))
  - [SensoryFeedback.Weight | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/sensoryfeedback/weight)
  - 重さで振動の質感を表す
  - .light（小さい、軽い素材のUIオブジェクト間の衝突）, .medium（軽すぎず、重すぎない素材のUIオブジェクト間の衝突）, .hard（重い素材のUIオブジェクト間の衝突）から選択できる
- [impact(flexibility:intensity:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/sensoryfeedback/impact(flexibility:intensity:))
  - [impact(weight:intensity:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/sensoryfeedback/flexibility)
  - impactのflexibilityパラメータは振動の質感を選択する
  - .rigid（硬い素材のUIオブジェクト間の衝突）, .soft（柔らかい素材のUIオブジェクト間の衝突）, .solid（柔らかすぎず、硬すぎない素材のUIオブジェクト間の衝突）から選択できる
