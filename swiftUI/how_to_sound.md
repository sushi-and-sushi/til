# how_to_sound

## とりあえず動かす

### View

```Swift
import SwiftUI
import Combine
import AVFoundation

struct ContentView: View {
    @State private var player = PlayerModel()

    var body: some View {
        Button {
            player.playAudio()
        } label: {
            Text("Play")
                .font(.largeTitle)
        }
    }
}

class PlayerModel: NSObject, ObservableObject {
    var audioPlayer: AVAudioPlayer?

    func playAudio() {
        guard let dataAsset = NSDataAsset(name: "sound") else { return }

        do {
            audioPlayer = try AVAudioPlayer(data: dataAsset.data)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Failed to create the audio player: \(error)")
        }

    }
}
```

## メモ

- 音声ファイルや映像ファイルをアセットカタログから読み込むのには`NSSataAsset`を利用する
- `prepareToPlay()`
  - 必要なデータを事前に読み込ませることができる。ボタンを押した直後に音声再生することができる
  - 通常はわずかに遅延が発生する
  - 大容量、長時間のファイルは向いていない
- アセットカタログに入れず、`Bundle.main.url(forResource:withExtension:)`で直接ファイルを指定するのが一般的？
