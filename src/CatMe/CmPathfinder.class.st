Class {
	#name : #CmPathfinder,
	#superclass : #Object,
	#instVars : [
		'tunnels',
		'goalExit',
		'catPos',
		'graph'
	],
	#category : #CatMe
}

{ #category : #private }
CmPathfinder class >> createDenseEdgesOf: aSet withWeight: aBlockClosure [

^ aSet flatCollect: [ :outer |	
		(aSet
			select: [ :inner | inner ~= outer ]) 
			flatCollect: [ :inner |
				| weight |
				"get weight via closure"
				weight := aBlockClosure value: inner value: outer.
				{{ inner . outer . weight }. { outer . inner . weight }}.
		]
	].

]

{ #category : #private }
CmPathfinder class >> distanceFromPoint: point toLineSegmentFrom: lineStart to: lineEnd [
    | lineVector pointVector scalar t closestPoint dotProd |

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

{ #category : #initialize }
CmPathfinder class >> tunnels: aSet [
| obj |
obj := self new.
obj tunnels: aSet.
^ obj.
]

{ #category : #private }
CmPathfinder class >> weightForEdgeFrom: aPointFrom to: aPointTo withCatPos: aPointCat [
| weight edgeLength catToEdgeDistance |

"Calculate the distance between the two exit points"
edgeLength := aPointFrom distanceTo: aPointTo.

aPointCat ifNil: [ ^ edgeLength ].

"Calculate the distance from the cat to the edge"
catToEdgeDistance := self distanceFromPoint: aPointCat toLineSegmentFrom: aPointFrom to: aPointTo.

"Calculate the weight based on the exit points distance and the cat's distance to the edge"
weight := edgeLength * (1 / catToEdgeDistance).

^ weight
]

{ #category : #private }
CmPathfinder >> createNodesAndEdges [
| edges nodes |

edges := Set new.
nodes := Set new.

"add exits to nodes and calculate edges with 0 weight within tunnels"
tunnels do: [ :t | 
	| exits tunnelEdges |
	exits := t exits.
	nodes addAll: exits.
	
	tunnelEdges := self class createDenseEdgesOf: exits withWeight: [ :e1 :e2 | 0 ]. 
	edges addAll: tunnelEdges.	
].

"add dense edges between all nodes in graph with weight depending on distance and cat position"
edges addAll: (self class 
	createDenseEdgesOf: nodes 
	withWeight: [ :e1 :e2 | 
		self class weightForEdgeFrom: e1 pos to: e2 pos withCatPos: catPos 
		]
).

^ {nodes . edges}.

]

{ #category : #computation }
CmPathfinder >> nextAfter: anExit [
"returns the next exit on the path"
| path |

"set start/end to anExit"
graph end: anExit.
"reconstruct path from goal to anExit"
path := graph reconstructPath.

"since the first and the last one are from and to, we want the pre last one"
^ path size = 1 
		ifTrue: [ path last ] 
		ifFalse: [ path at: path size - 1 ]
]

{ #category : #computation }
CmPathfinder >> rerun [
| nodes edges nodeEdges |

"create nodes and edges"
nodeEdges := self createNodesAndEdges.
nodes := nodeEdges first.
edges := nodeEdges second.

"create graph"
graph := AIDijkstra new.
graph nodes: nodes.
graph 
	edges: edges
	from: #first
	to: #second
	weight: #third.
	
"run graph calculation from goalExit"
graph runFrom: goalExit.
]

{ #category : #accessing }
CmPathfinder >> tunnels: aSet [
tunnels := aSet.

"search for the goal tunnel and take one of its exits"
goalExit := (tunnels select: [ :t | t isGoal ]) anyOne exits anyOne.
]

{ #category : #accessing }
CmPathfinder >> updateCatPosition: aPoint [
| oldPos |

oldPos := catPos.
catPos := aPoint.

(catPos = oldPos) ifTrue: [ ^ nil. ].

"if incoming position is new, we trigger a recalculation"
self rerun.
]
