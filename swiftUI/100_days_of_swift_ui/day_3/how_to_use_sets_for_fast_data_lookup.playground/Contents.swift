import Cocoa

// セットを使用して高速なデータ検索を行う方法

// セットは、重複する項目を追加できず、項目を特定の順序で格納しない
// 配列を作成して、それをSet()で囲む
// 重複する値は記憶されない（重複する値が入ってたor追加としてもエラーは起きず、自動で削除される）

let people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
print(people) // 元の並びで表示されることもあるが、異なる順番で表示される場合もある。セットは順番を気にしない

// セットで項目を追加する時は、配列のようなappend()ではなく、insert()を使う
var people2 = Set<String>()
people2.insert("Denzel Washington")
people2.insert("Tom Cruise")
people2.insert("Nicolas Cage")
people2.insert("Samuel L Jackson")
print(people2)

// セットは、順番も保持しないし重複もできないが、これらの制約は利点になる
// ほとんどの場合、値の集合には配列を使うことになるが、大量のデータを扱うならセットも候補に挙がってくるだろう

// 重複させたくない用途の場合にはセットを使う

// 順番を保持しない代わりに、セットは最適化された順序で保存し、アイテムの検索が非常に速くなる。
// 1,000個の値を持つ配列に対し、contains()で指定した値が含まれているか確認する場合、
// Swiftは一致する項目が見つかるまですべての項目を通過しなければならない。
// falseを返すまでに、1.000個の値をチェックする必要があるかもしれない。

// セットにも、countやsorted()のような便利機能が用意されている

let setStudy = Set([1])
