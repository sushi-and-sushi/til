import Cocoa

// https://qiita.com/yoshitaka/items/0cb287a346c3256b4b52
// https://zenn.dev/kabeya/books/casepath-guide/viewer/020-whats-keypath

// 1.使い方がわかりやすい基本形

struct SomeStructure {
    var someValue: Int
}

// sにsomeValue: 12のSomeStructure()のインスタンスを作成している
let s: SomeStructure = .init(someValue: 12)

// pathToPropertyに「キーパス」を保存している.住所情報.\ルート型名.パス
let pathToProperty = \SomeStructure.someValue

// pathToPropertyに保存している住所に基づき、SomeStructureのインスタンスであるsのsomeValueの値をvalueに格納している
// keyPathを使ってプロパティの値にアクセスするには、[keyPath: xxx]という表記を用いる。辞書型ではない。
let value = s[keyPath: pathToProperty]

// 2.複数の階層にまたがる構成要素を含められる

struct ParentData { var children: [ChildData] }
struct ChildData { var grandChild: GrandChildData? }
struct GrandChildData { var value: Int }

let path1 = \ParentData.children[0].grandChild?.value // まだ存在しなくてもエラーにならない
let path2 = \ParentData.children[1].grandChild!.value

let data = ParentData(children: [
    ChildData(grandChild: nil),
    ChildData(grandChild: GrandChildData(value: 4))
])

print("path1 value: \(data[keyPath: path1])")
print("path2 value: \(data[keyPath: path2])")
