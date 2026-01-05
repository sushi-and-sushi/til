# controlling_simple_animations

SwiftUIでシンプルなトランジション、イージングアニメーションを再生させる方法を理解する

## `.transition(_:)`

[transition(_:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/view/transition(_:))

ビューの表示/非表示時のアニメーションを定義する
`.opacity`, `.scale`, `.slide`, `.move(edge:)`など、簡単に使えるものがある
`AnyTransition`型に準拠すれば、カスタムトランジションを作ることも可能

### `.transition()` のイージングを試す

```swift
struct EasyTransitionView: View {
    @State private var isActive: Bool = false
    @State private var selectedTransition: Transition = .opacity

    var body: some View {
        VStack(spacing: 24) {
            VStack {
                if isActive {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(Color.red)
                        .font(Font.system(size: 100))
                        .transition(AnyTransition(selectedTransition.transition))
                }
            }
            .frame(height: 100)

            Picker("Transition", selection: $selectedTransition) {
                ForEach(Transition.allCases, id: \.self) { transition in
                    Text(transition.displayName).tag(transition)
                }
            }

            Button("Toggle") {
                withAnimation {
                    isActive.toggle()
                }
            }
        }
    }
}

enum Transition: CaseIterable {
    case blurReplace
    case identity
    case move
    case offset
    case opacity
    case push
    case scale
    case slide

    var transition: any SwiftUI.Transition {
        switch self {
            case .blurReplace:
                return .blurReplace
            case .identity:
                return .identity
            case .move:
                return .move(edge: .top)
            case .offset:
                return .offset(y: 20)
            case .opacity:
                return .opacity
            case .push:
                return .push(from: .top)
            case .scale:
                return .scale
            case .slide:
                return .slide
        }
    }

    // Pickerでの選択肢用のラベル名
    var displayName: String {
        switch self {
            case .blurReplace:
                return "Blur Replace"
            case .identity:
                return "Identity"
            case .move:
                return "Move"
            case .offset:
                return "Offset"
            case .opacity:
                return "Opacity"
            case .push:
                return "Push"
            case .scale:
                return "Scale"
            case .slide:
                return "Slide"
        }
    }
}
```

### トランジションの種類

#### `.blurReplace`

表示状態をぼかし効果をかけながら切り替える。綺麗。

#### `.identity`

表示状態を一瞬で切り替える

#### `.move(edge:)`

指定したEdgeに一瞬で出現し、表示する座標へ滑らかに移動する。
非表示時は逆の流れとなる。

#### `.offset(x:y:)`

表示位置からどれくらい離れて表示するか指定できる.moveみたいなもの

#### `.opacity`

表示状態を切り替える際に、透明度変化を滑らかに表現する

#### `.push(from:)`

.moveの様に表示状態を切り替えるが、一緒に透明度変化の効果も表現する

#### `.scale`

表示は縮小状態から拡大し、非表示は縮小して消える
.scale(scale:anchor:)でズーム度合いと、効果の起点となる位置を指定可能。

#### `.slide`

出現する時は左側に現れて指定の座標に移動。非表示になる時は表示位置から右に移動して非表示化

### 気付き

- .combinedを使うとトランジション効果は重ね掛けできる
  - slide＋透明度の変化、など
  - 例: .transition(.scale.combined(with: .opacity))
  - Figmaでは作れない

## `withAnimation(_:_:)`

[withAnimation(_:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/withanimation(_:_:))

指定されたイージングアニメーションを使用して、Viewの再計算した結果を返す
animationパラメータにAnimation型の値を指定して、時間の経過に対する値の変化速度を制御する

### SwiftUIにデフォルトで存在するイージング（Animation）を試す

```swift
import SwiftUI

struct AnimationView: View {
    @State private var isActive: Bool = false
    @State private var selectedAnimation: Animation = .animeDefault

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "heart.fill")
                .foregroundStyle(Color.red)
                .font(Font.system(size: 100))
                .offset(x: isActive ? 100 : -100)

            Picker("Animation", selection: $selectedAnimation) {
                ForEach(Animation.allCases, id: \.self) { animation in
                    Text(animation.displayName).tag(animation)
                }
            }

            Button("Toggle") {
                withAnimation(selectedAnimation.animation) {
                    isActive.toggle()
                }
            }
        }
    }
}

enum Animation: CaseIterable {
    case animeDefault
    case linear
    case easeIn
    case easeOut
    case easeInOut
    case bouncy
    case smooth
    case snappy
    case spring
    case interactiveSpring

    // イージングの指定
    var animation: SwiftUI.Animation {
        switch self {
            case .animeDefault:
                return .default
            case .linear:
                return .linear
            case .easeIn:
                return .easeIn
            case .easeOut:
                return .easeOut
            case .easeInOut:
                return .easeInOut
            case .bouncy:
                return .bouncy
            case .smooth:
                return .smooth
            case .snappy:
                return .snappy
            case .spring:
                return .spring
            case .interactiveSpring:
                return .interactiveSpring
        }
    }

    // Pickerでの選択肢用のラベル名
    var displayName: String {
        switch self {
            case .animeDefault:
                return "Default (spring)"
            case .linear:
                return "Linear"
            case .easeIn:
                return "Ease In"
            case .easeOut:
                return "Ease Out"
            case .easeInOut:
                return "Ease In Out"
            case .bouncy:
                return "Bouncy"
            case .smooth:
                return "Smooth"
            case .snappy:
                return "Snappy"
            case .spring:
                return "Spring"
            case .interactiveSpring:
                return "Interactive Spring"
        }
    }
}
```

## `.animation(_:value:)`

[animation(_:value:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/view/animation(_:value:))

SwiftUIらしい宣言的な？記述を重視する書き方？

```Swift
struct ContentView: View {
    @State private var isActive: Bool = false
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "heart.fill")
                .foregroundStyle(Color.red)
                .font(Font.system(size: 100))
                .scaleEffect(scale)
                .animation(
                    .spring(response: 0.5, dampingFraction: 0.6),
                    value: scale
                )

            Button("Toggle") {
                scale = isActive ? 1.0 : 1.5
                isActive.toggle()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}
```

### イージングアニメーションの種類

標準のイージングには`duration: TimeInterval`パラメータがあり、イージングの長さを指定可能。

#### `.default`

内実は`spring(response: 0.55, dampingFraction: 1.0, blendDuration: 0.0)`。

iOS 17, macOS 14, tvOS 17, and watchOS 10 以前は easeInOut。

#### `.linear`

線形に移動する。

Documentでは「機械的な印象を抱かせる」と言われている

#### `.easeIn`

ゆっくり動き始め、動きの終わりに向かって加速する

#### `.easeOut`

動きの始まりに加速し、動きの終わりに向かって減速する。

勢いがわかりやすくて見やすい気がする。

#### `.easeInOut`

`.easeIn`、`.easeOut`を組み合わせたイージング

Documentでは「現実世界の物体の動きに自然な動きを実現する」とされている

自然なので、ユーザーを驚かせずにアニメーションさせることができそう

#### スプリングアニメーション

強度やキャラクター別に用意されており、`.bouncy`、`.smooth`、`.snappy`が存在する。

カスタマイズできる`.spring`、`.interactiveSpring`、`.interpolatingSpring`も存在する。

- `.bouncy`：弾む力が強い
- `.smooth`：弾む力が無い
- `.snappy`：きびきびして、少しだけ弾む力を持つ
- `.spring`：上記ではニーズに沿わない場合にカスタムするためのアニメーション
- `.interactiveSpring`：名の通りインタラクティブな操作での使用に向いている。わずかに弾む力があり、素早い
- `.interpolatingSpring`：減衰振動モデル。表現するためのアニメーションに使えそう。（落ちかけている看板の様なイメージ...?）
