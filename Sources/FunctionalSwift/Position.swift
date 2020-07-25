import Foundation

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    
    var length: Double {
        return sqrt(x * x + y * y)
    }
	
    func within(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }

    func minus(_ p: Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }
}
