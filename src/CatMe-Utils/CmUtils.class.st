Class {
	#name : #CmUtils,
	#superclass : #Object,
	#category : #'CatMe-Utils'
}

{ #category : #'graph - calculation' }
CmUtils class >> distanceFromPoint: point toLineSegmentFrom: lineStart to: lineEnd [
    | lineVector pointVector projection scalar t closestPoint dotProd |

    lineVector := lineEnd - lineStart.
    pointVector := point - lineStart.

    "Calculate the scalar projection of the point vector onto the line vector"
    scalar := pointVector dotProduct: lineVector.
	 dotProd := (lineVector dotProduct: lineVector).
    t := (dotProd = 0) ifTrue: [ 1 ] ifFalse: [ scalar / dotProd ].

    "Clamp t to the [0, 1] range, representing the line segment"
    t := (t max: 0) min: 1.

    "Find the closest point on the line segment"
    closestPoint := lineStart + (lineVector * t).

    "Calculate the distance from the point to the closest point on the line segment"
    ^ point distanceTo: closestPoint

]

{ #category : #random }
CmUtils class >> randomBoardPosition [
	| randomX randomY |
	"generate position"
	randomX := (0 to: CmBoard boardLength - 50) atRandom.
	randomY := (0 to: CmBoard boardLength - 50) atRandom.
	
	^ randomX@randomY
]

{ #category : #'graph - calculation' }
CmUtils class >> weightForEdgeFrom: exitPoint1 to: exitPoint2 catPosition: playerPoint [
    | distance exitPointsDistance playerEdgeDistance |

    "Calculate the distance between the two exit points"
    exitPointsDistance := exitPoint1 distanceTo: exitPoint2.

    "Calculate the distance from the player to the edge"
    playerEdgeDistance := self distanceFromPoint: playerPoint toLineSegmentFrom: exitPoint1 to: exitPoint2.

    "Calculate the weight based on the exit points distance and the player's distance to the edge"
    distance := exitPointsDistance * (1 / playerEdgeDistance).

    ^ distance
]
