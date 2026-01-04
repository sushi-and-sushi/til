# withAnimation_and_transition

- トランジション効果は重ね掛けできる
  - slideと透明度の変化と、など
  - 例: .transition(.scale.combined(with: .opacity))

## `.transition()` モディファイア

ビューの表示/非表示時のアニメーションを定義する
`.opacity`, `.scale`, `.slide`, `.move(edge:)`など、簡単sに使えるものがある
`AnyTransition`型に準拠すれば、カスタムトランジションも作ることができる

### `.transition()` の使用例

```swift
struct EasyTransition: View {
    @State private var isActive: Bool = false

    var body: some View {
        if isActive {
            Text("Hello, world!")
                .transition(.slide)
        }
        Button("Toggle") {
            withAnimation {
                isActive.toggle()
            }
        }

    }
}
```

## `withAnimation()` モディファイア

[withAnimation(_:_:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/withanimation(_:_:))

指定されたアニメーションを使用して、Viewを再計算した結果を返す
animationパラメータにAnimation型の値を指定して、時間の経過に対する値の変化速度を制御する

## SwiftUIにデフォルトで存在するイージング（Animation）を試す

```swift
struct AnimationView: View {
    @State private var isActive: Bool = false
    @State private var selectedAnimation: Animation = .animeDefault

    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .foregroundStyle(Color.red)
                .font(Font.system(size: 100))
                .offset(x: isActive ? 100 : -100)
        }
        .frame(width: 100, height: 100)
        .padding(24)

        Picker("Animation", selection: $selectedAnimation) {
            // コレクションを繰り返し呼び出す
            // enum animation を ForEach で呼び出せる様にする
            // .allCases は enum に CaseIterable プロトコルに準拠させることで、使えるようになる
            ForEach(Animation.allCases, id: \.self) { animation in
                // animation.displayName で String のラベル名を呼び出せる
                //.tag()は 一意で識別できればいい
                Text(animation.displayName).tag(animation)
            }
        }
        .padding(24)

        Button("Toggle") {
            withAnimation(selectedAnimation.animation) {
                isActive.toggle()
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

    var animation: SwiftUI.Animation {
        // 型はAnimationだとこのenum自体のことを指してしまう
        // イージングのAnimation型は、SwiftUI.Animationと書く
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

### `.default`

内実は、`spring(response: 0.55, dampingFraction: 1.0, blendDuration: 0.0)`
iOS 17, macOS 14, tvOS 17, and watchOS 10 以前は easeInOut。
後ほど他の種類も確認していきたい。
