"
I am the CatMe gameboard which holds the logic for a game round. I also represent a BlElement and therefore can be rendered.
"
Class {
	#name : #CmBoard,
	#superclass : #BlElement,
	#instVars : [
		'isRunning',
		'cat',
		'tunnels',
		'mice',
		'goalTunnel',
		'dijkstraGraph',
		'fpsElement'
	],
	#category : #CatMe
}

{ #category : #constants }
CmBoard class >> boardLength [
^1000
]

{ #category : #accessing }
CmBoard >> dijkstra [
^ dijkstraGraph.
]

{ #category : #initialization }
CmBoard >> initialize [ 

super initialize.

tunnels := Set new.
mice := Set new.

self initializeElementsAndAppearance.
self initializeInteractivity.
self initializeMouseRunningPaths.

self initializeDebugInfo.
]

{ #category : #initialization }
CmBoard >> initializeDebugInfo [

CmSettings debugFPS ifTrue: [ 
		fpsElement := BlTextElement new
			text: 'FPS: ...' asRopedText;
			position: 10@10.
		self addChild: fpsElement.
	 ]
]

{ #category : #initialization }
CmBoard >> initializeElementsAndAppearance [
self size: self class boardLength asPoint.

"generate tunnels"
1 to: CmSettings tunnelNumber do: [ :nr |
		| tunnel |
		tunnel := CmTunnel new.
		self addChildren: tunnel exits asArray.
		tunnels add: tunnel.
	 ].

"set goal tunnel"
goalTunnel := tunnels asArray first.
goalTunnel isGoal: true.

1 to: CmSettings miceNumber do: [ :nr |
		| mouse initTunnel initExit |
		mouse := CmMouse new.
		
		initTunnel := (tunnels select: [ :t | t ~= goalTunnel ]) asArray atRandom.
		initExit := initTunnel exits asArray atRandom.
		mouse pos: initExit pos.
		mouse initialExit: initExit.
		mouse nextTargetClb: [ :current | self nextExit: current ].
		
		self addChild: mouse.
		mice add: mouse.
	].

"generate cat"
cat := CmCat new.

self addChild: cat.
]

{ #category : #initialization }
CmBoard >> initializeInteractivity [

]

{ #category : #initialization }
CmBoard >> initializeMouseRunningPaths [

	| nodes edges edgeAdder |
	nodes := Set new.
	edges := Set new.

	"closure that adds all combinations of given exits as edges"
	"if dist is not null, dist overrides the actual distance"
	edgeAdder := [ :exits :dist |
	             exits do: [ :first |
		             (exits select: [ :el | el ~= first ]) collect: [ :second |
			             | distance |
			             distance := first pos distanceTo: second pos.
			             dist ifNotNil: [ distance := 0 ].
			             edges add: {
					             first.
					             second.
					             distance }.
			             edges add: {
					             second.
					             first.
					             distance } ] ] ].

	"add all exit combinations within tunnel and set the weight to 0"
	tunnels do: [ :t |
		| exits |
		exits := t exits.
		nodes addAll: exits.
		edgeAdder value: exits value: 0 ].

	"add the combindations of all exits to the graph with the distance as weight"
	edgeAdder value: nodes value: nil.

	"setup dijkstra graph"
	dijkstraGraph := AIDijkstra new.
	dijkstraGraph nodes: nodes.
	dijkstraGraph
		edges: edges
		from: #first
		to: #second
		weight: #third.

	"run calculation"
	dijkstraGraph runFrom: goalTunnel exits asArray anyOne.
]

{ #category : #'mouse-path' }
CmBoard >> nextExit: anExit [
"returns a mouse should run to"
"anExit is the current exit of the mouse"
| path |

dijkstraGraph end: anExit.

path := dijkstraGraph reconstructPath.
 
"since the first and the last one are from and to, we want the pre last one"
 ^ path size = 1 ifTrue: [ path last ] ifFalse: [ path at: path size - 1 ]
]

{ #category : #'game-logic' }
CmBoard >> start [

isRunning := true.
[ 
	| frameCount lastFPSCalculationTime atLimit|
	(Delay forMilliseconds: CmSettings startupDelay) wait.
	
	frameCount := 0.
	lastFPSCalculationTime := Time millisecondClockValue.
	atLimit := false.
	
	[ isRunning  ] whileTrue: [ 
		| startTime currentTime elapsedTime |
		startTime := Time millisecondClockValue.
	
		self tick.
		
		frameCount := frameCount + 1.
		currentTime := Time millisecondClockValue.
		elapsedTime := currentTime - startTime.
		
		"Check if a second has passed since the last FPS calculation"
		(currentTime - lastFPSCalculationTime >= 500) ifTrue: [ 
			self updateFPS: frameCount * 2 atLimit: atLimit.
			frameCount := 0.
			lastFPSCalculationTime := currentTime. 
			atLimit := false.
			].
			
		"Check elapsedTime was greater than wanted delay"
		(CmSettings tickDelayMS < elapsedTime ) ifTrue: [ 
			atLimit := true. 
			].
			
		(Delay forMilliseconds: (CmSettings tickDelayMS - elapsedTime max: 0)) wait.
	].
	
	self inform: 'Game round stopped'.
] fork.
]

{ #category : #'game-logic' }
CmBoard >> stop [
isRunning := false
]

{ #category : #'game-logic' }
CmBoard >> tick [
"executes all updates for a tick"

cat update.

mice do: [ :mouse |
		mouse update.
	].
]

{ #category : #accessing }
CmBoard >> tunnels [
^ tunnels
]

{ #category : #accessing }
CmBoard >> updateFPS: aNumber atLimit: aBoolean [

fpsElement ifNil: [ ^ nil ].

fpsElement text: ('FPS: ', aNumber asString) asRopedText.

aBoolean ifTrue: [ fpsElement background: Color red. ] ifFalse: [ fpsElement background: Color transparent ]
]
