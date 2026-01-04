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
                // 変化前、変化後をcontentに対して指定することで、アニメーションさせる
                // フェーズのBool値によって、 -40.0 と 0.0 を切り替える
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
                // フェーズ毎にAnimationを変更している.単に.bouncyと一つの種類を指定することも可能
                phase ? .bouncy : .default
            }
            .onTapGesture {
                likeCount += 1
            }
    }
}
```

### 段階をより増やしてアニメーションする

#### フェーズのリストを定義する

```Swift
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
```

#### Viewを調整する

```Swift
struct ThreePhaseAnimationView: View {
    var emoji: String
    @State private var likeCount = 1

    var body: some View {
        EmojiView(emoji: emoji)
            // AnimationPhase.allCasesでenumで書いたケースを対象としている
            .phaseAnimator(AnimationPhase.allCases, trigger: likeCount) { content, phase in
                content
                    .scaleEffect(phase.scaleEffect)
                    .offset(y: phase.verticalOffset)
            } animation: { phase in
                // AnimationPhaseのケース毎にアニメーション種別を指定
                switch phase {
                case .initial: .smooth
                case .move: .easeInOut(duration: 0.3)
                case .scale: .spring(duration: 0.3, bounce: 0.7)
                }
            }
            .onTapGesture {
                likeCount += 1
            }
    }
}
```

## KeyframeAnimator

アニメーションを適用したいビューに[keyframeAnimator(initialValue:repeating:content:keyframes:)](https://developer.apple.com/documentation/swiftui/view/keyframeanimator(initialvalue:repeating:content:keyframes:))または[keyframeAnimator(initialValue:trigger:content:keyframes:)](https://developer.apple.com/documentation/swiftui/view/keyframeanimator(initialvalue:trigger:content:keyframes:))を適用する

```Swift
struct KeyframeAnimationView: View {
    var emoji: String
    @State private var likeCount = 1

    var body: some View {
        EmojiView(emoji: emoji)
            .keyframeAnimator(
                initialValue: AnimationValues(), // アニメーションで変化させる値の初期値
                trigger: likeCount
            ) { content, value in
                content // アニメーション対象のView
                    .rotationEffect(value.angle) // アニメーションで変化するvalueのプロパティの値を利用している
                    .scaleEffect(value.scale)
                    .scaleEffect(y: value.verticalStretch)
                    .offset(y: value.verticalOffset)
            } keyframes: { _ in
                // キーフレームを整理するトラックを作成。引数には操作したいプロパティへのキーパスを指定
                KeyframeTrack(\.scale) {
                    // キーフレームには、LinearKeyframe, SpringKeyframe, CubicKeyframeなど色々ある
                    // 第一引数にはこのキーフレームで到達する値、第二引数には前の状態からこのキーフレームに到達するまでの時間（秒）を指定
                    LinearKeyframe(1.0, duration: 0.36)
                    SpringKeyframe(1.5, duration: 0.8, spring: .bouncy)
                    SpringKeyframe(1.0, spring: .bouncy)
                }

                KeyframeTrack(\.verticalOffset) {
                    LinearKeyframe(0.0, duration: 0.1)
                    SpringKeyframe(20.0, duration: 0.15, spring: .bouncy)
                    SpringKeyframe(-60.0, duration: 1.0, spring: .bouncy)
                    SpringKeyframe(0.0, spring: .bouncy)
                }

                KeyframeTrack(\.verticalStretch) {
                    CubicKeyframe(1.0, duration: 0.1)
                    CubicKeyframe(0.6, duration: 0.15)
                    CubicKeyframe(1.5, duration: 0.1)
                    CubicKeyframe(1.05, duration: 0.15)
                    CubicKeyframe(1.0, duration: 0.88)
                    CubicKeyframe(0.8, duration: 0.1)
                    CubicKeyframe(1.04, duration: 0.4)
                    CubicKeyframe(1.0, duration: 0.22)
                }

                KeyframeTrack(\.angle) {
                    CubicKeyframe(.zero, duration: 0.58)
                    CubicKeyframe(.degrees(16), duration: 0.125)
                    CubicKeyframe(.degrees(-16), duration: 0.125)
                    CubicKeyframe(.degrees(16), duration: 0.125)
                    CubicKeyframe(.zero, duration: 0.125)
                }
            }
            .onTapGesture {
                likeCount += 1
            }
    }
}

private struct AnimationValues {
    var scale = 1.0
    var verticalStretch = 1.0
    var verticalOffset = 0.0
    var angle = Angle.zero
}
```
