import Cocoa

// ジェネリクスの雑理解

struct Greeting<T> {
    var value: T
}

let g1 = Greeting(value: "Hello, there!")
let g2 = Greeting(value: 42)
let g3 = Greeting(value: false)

print(g1.value)
print(g2.value)
print(g3.value)
