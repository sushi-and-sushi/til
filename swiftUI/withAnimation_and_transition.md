# withAnimation_and_transition

SwiftUIでシンプルなトランジション、イージングアニメーションを再生させる方法を理解する

## `.transition(_:)`

[transition(_:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/view/transition(_:))

ビューの表示/非表示時のアニメーションを定義する
`.opacity`, `.scale`, `.slide`, `.move(edge:)`など、簡単に使えるものがある
`AnyTransition`型に準拠すれば、カスタムトランジションを作ることも可能

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

### 気付き

- .combinedを使うとトランジション効果は重ね掛けできる
  - slide＋透明度の変化、など
  - 例: .transition(.scale.combined(with: .opacity))

## `.withAnimation(_:)`

[withAnimation(_:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/withanimation(_:_:))

指定されたアニメーションを使用して、Viewを再計算した結果を返す
animationパラメータにAnimation型の値を指定して、時間の経過に対する値の変化速度を制御する

## SwiftUIにデフォルトで存在するイージング（Animation）を試す

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
