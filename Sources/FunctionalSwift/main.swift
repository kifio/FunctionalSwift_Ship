typealias Distance = Double

func test() {
    let p0 = Position(x: 2.0, y: 2.0)
    let p1 = Position(x: 20.0, y: 20.0) 
    let shifted = shift(circle(radius: 10), by: Position(x: 5, y: 5))
    print("p0 is in shifted region: \(shifted(p0))")
    print("p1 is in shifted region: \(shifted(p1))")
}

test()
