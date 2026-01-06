# how_to_haptics

とにかく試す

```Swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Haptic Button") {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
}
```
