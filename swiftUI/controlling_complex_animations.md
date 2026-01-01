# controlling_complex_animations

[Controlling the timing and movements of your animations | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/controlling-the-timing-and-movements-of-your-animations)を読んで、SwiftUIでの複雑な制御やキーフレームによるアニメーションの作り方を理解したい

- SwiftUIにはシンプルな標準アニメーションが提供されているが、タイミングを細かく制御するための方法が存在する
- KeyframeAnimator, PhaseAnimatorはそういった制御を可能にする
- PhaseAnimator：Phaseと呼ばれる個別のステップの集合として定義できる
- KeyframeAnimator：視覚的なトランジション中、特定のタイミングでアニメーションの値を指定するキーフレームを作る

## PhaseAnimator

指定したフェーズのセットに基づいて、アニメーション化したトランジションを作成する

### 2段階でアニメーションする

「上に移動する」「下に移動する」という2つのフェーズが存在する場合、Bool値で状態遷移を表現できる
[phaseAnimator(_:content:animation:)](https://developer.apple.com/documentation/swiftui/view/phaseanimator(_:content:animation:))を使う

```Swift
struct TwoPhaseAnimationView: View {
    var emoji: String

    var body: some View {
        EmojiView(emoji: emoji)
            // 配列で渡した2つのフェーズをループする. 配列順に再生する
            .phaseAnimator([false, true]) { content, phase in
                // フェーズのBool値によって、 -40.0 と 0.0 で切り替わる
                // .offset　modifierは表示した場所から指定した分だけズラす
                content.offset(y: phase ? -40.0 : 0.0)
            }
    }
}
```

ループさせず再生のトリガーを設定するには、[phaseAnimator(_:trigger:content:animation:)](https://developer.apple.com/documentation/swiftui/view/phaseanimator(_:trigger:content:animation:))を使う

```Swift
struct TwoPhaseAnimationView: View {
    var emoji: String
    @State private var likeCount = 1

    var body: some View {
        EmojiView(emoji: emoji)
            // trigger：　変更を監視するトリガー値を指定する。値（likeCount）が変わるとアニメーションを再生
            // animation: Animationの種類を指定できる
            .phaseAnimator([false, true], trigger: likeCount) { content, phase in
                content.offset(y: phase ? -40.0 : 0.0)
            } animation: { phase in
                // フェーズ毎にAnimationを変更している.単に.bouncyと書くだけでも可能
                phase ? .bouncy : .default
            }
            .onTapGesture {
                likeCount += 1
            }
    }
}
```

<!-- #### フェーズのリストを定義する -->

<!-- ```Swift
private enum AnimationPhase: CaseIterable {
    case initial
    case move
    case scale

    // ロジック簡素化のために、以下に　computed property を定義する
    // 絵文字を動かすために、垂直のオフセット値を返す
    var verticalOffset: Double {
        switch self {
        case .initial: 0
        case .move, .scale: -64 // caseを兼ねることができる。　.move, .scaleに-64を割り当てる
        }
    }

    // 絵文字のスケールを変更する
    var scaleEffect: Double {
        switch self {
        case .initial: 1
        case .move, .scale: 1.5
        }
    }
}
``` -->

<!-- TODO：ここから再開する。To animate an emoji, apply the phaseAnimator(_:trigger:content:animation:) modifier to the EmojiView. Provide the animator all cases from the custom AnimationPhase type. Then change the content based on the phase by applying the scaleEffect(_:anchor:) and offset(x:y:) modifiers. The values passed into these modifiers come from the computed properties, which helps keep the view code more readable. -->

## KeyframeAnimator
