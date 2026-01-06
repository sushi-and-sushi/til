# how_to_haptics

とにかく試す

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
