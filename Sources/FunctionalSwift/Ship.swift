import Foundation

typealias Region = (Position) -> Bool

func circle(radius: Distance) -> Region {
    return { point in point.length <= radius }
}

func shift(_ region: @escaping Region, by offset: Position) -> Region {
    return { point in region(point.minus(offset)) }
}

func invert(_ region: @escaping Region) -> Region {
    return { point in !region(point) }
}

func intersect(_ region: @escaping Region, with other: @escaping Region) -> Region {
    return { point in region(point) && other(point) }
}

func union(_ region: @escaping Region, with other: @escaping Region) -> Region {
    return { point in region(point) || other(point)  }
}

func subtract(_ region: @escaping Region, from original: @escaping Region) -> Region {
    return intersect(original, with: invert(region))
}

struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}

extension Ship {
    func canEngage(ship target: Ship) -> Bool  {
        let dx = target.position.x - position.x
	let dy = target.position.y - position.y
	let targetDistance = sqrt(dx * dx + dy * dy)
	return targetDistance <= firingRange
    }

    func canSafelyEngage(ship target: Ship) -> Bool {
        let dx = target.position.x - position.x
	let dy = target.position.y - position.y
	let targetDistance = sqrt(dx * dx + dy * dy)
	return targetDistance < firingRange && targetDistance > unsafeRange
    }

    func canSafelyEngage(ship target: Ship, friendly: Ship) -> Bool {
        let rangeRegion = subtract(circle(radius: unsafeRange), from: circle(radius: firingRange))
	let firingRegion = shift(rangeRegion, by: position)
	let friendlyRegion = shift(circle(radius: unsafeRange), by:friendly.position)
	let resultRegion = subtract(friendlyRegion, from: firingRegion)
	return resultRegion(target.position)
	
    } 
}
