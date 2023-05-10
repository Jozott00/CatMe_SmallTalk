"
I am the CatMe gameboard which holds the logic for a game round. I also represent a BlElement and therefore can be rendered.
"
Class {
	#name : #CmBoard,
	#superclass : #BlElement,
	#instVars : [
		'cat',
		'tunnels',
		'mice',
		'pathFinder',
		'fpsElement',
		'scoreboardElem',
		'tickCount'
	],
	#category : #CatMe
}

{ #category : #constants }
CmBoard class >> boardLength [
^1000
]

{ #category : #accessing }
CmBoard >> catSeen [

pathFinder updateCatPosition: cat pos.
]

{ #category : #'update cycle' }
CmBoard >> checkMiceCatches [

mice 	select: [ :mouse | mouse hides not & mouse inGame & (cat collidesWith: mouse) ] 
		thenDo: [ :mouse |
			mouse caughtBy: cat.
	 	]
]

{ #category : #accessing }
CmBoard >> exits [ 
^ tunnels flatCollect: [ :t | t exits ]
]

{ #category : #initialization }
CmBoard >> initialize [ 

super initialize.

tickCount := 0.
tunnels := Set new.
mice := Set new.

self initializeAppearance.

self initializeTunnels.
self initializeMice.
self initializeCat.
self initializeScoreboard.

self initializePathfinder.

self initializeDebugInfo.
]

{ #category : #initialization }
CmBoard >> initializeAppearance [

self size: self class boardLength asPoint.

]

{ #category : #initialization }
CmBoard >> initializeCat [

"generate cat"
cat := CmCat new.
self addChild: cat.
]

{ #category : #initialization }
CmBoard >> initializeDebugInfo [

CmSettings debugFPS ifTrue: [ 
		fpsElement := BlTextElement new
			text: 'FPS: ...' asRopedText;
			position: (CmBoard boardLength - 100)@10;
			defaultFontSize: 20.
		self addChild: fpsElement.
	]
]

{ #category : #initialization }
CmBoard >> initializeMice [

1 to: CmSettings miceNumber do: [ :nr |
		| mouse initTunnel initExit |
		mouse := CmMouse new.
		
		initTunnel := (tunnels select: [ :t | t isGoal not ]) asArray atRandom.
		initExit := initTunnel exits asArray atRandom.
		mouse pos: initExit pos.
		mouse initialExit: initExit.
		mouse nextTargetClb: [ :current | 
			| mouseGoesHiding nextExit |
			
			nextExit := pathFinder nextAfter: current.
			
			"if mouse is currently not hiding in tunnel and is going into tunnel"
			mouseGoesHiding := mouse hides not & (nextExit tunnel = current tunnel).
			 
			"if the mouse goes from surface to underground, spread cat seen"
			mouseGoesHiding ifTrue: [pathFinder updateCatPosition: cat pos.self catSeen].
			
			nextExit  
			].
		
		self addChild: mouse.
		mice add: mouse.
	].
]

{ #category : #initialization }
CmBoard >> initializePathfinder [

pathFinder := CmPathfinder tunnels: tunnels.

"initial pathfinding"
pathFinder rerun.
]

{ #category : #initialization }
CmBoard >> initializeScoreboard [

"scoreboard"
scoreboardElem := CmScoreBoard new.
self addChild: scoreboardElem.

]

{ #category : #initialization }
CmBoard >> initializeTunnels [

"generate tunnels"
1 to: CmSettings tunnelNumber do: [ :nr |
		| tunnel |
		tunnel := CmTunnel exitPositionGenerator: [ :numberOfExits |
			| exitPositions |
			exitPositions := self exits collect: [ :e | e pos ].
			CmUtils randomExitPositions: numberOfExits notIn: exitPositions spacing: 100. 
			].
		self addChildren: tunnel exits asArray.
		tunnels add: tunnel.
	 ].

"set goal tunnel"
tunnels asArray first isGoal: true.
]

{ #category : #testing }
CmBoard >> isFinishState [
| result |

result := true.
^ mice allSatisfy: [ :mouse |
	mouse inGame not.
	].
]

{ #category : #accessing }
CmBoard >> miceWithState: aMouseState [
"sums that mice with a given CmMouseState"
^ mice sum: [ :mouse | (mouse state = aMouseState) ifTrue: [ 1 ] ifFalse: [ 0 ] ]
]

{ #category : #accessing }
CmBoard >> tunnels [
^ tunnels
]

{ #category : #'game-logic' }
CmBoard >> update [
"executes all updates for a tick"

"update cat"
cat update.

"udpate mice"
mice do: [ :mouse |
		mouse update.
	].

"check mice catches"
self checkMiceCatches.

"update scoreboard"
(tickCount % CmSettings findPathEveryXTicks = 0) ifTrue: [ 
	self updateScoreboard. 
	].

]

{ #category : #accessing }
CmBoard >> updateFPS: aNumber atLimit: aBoolean [
| border |
fpsElement ifNil: [ ^ nil ].

fpsElement text: ('FPS: ', aNumber asString) asRopedText.

border := BlBorder builder paint: Color red; width: 2; build.
aBoolean ifTrue: [ fpsElement border: border. ] ifFalse: [ fpsElement border: nil ]
]

{ #category : #'update cycle' }
CmBoard >> updateScoreboard [
| miceAtGoal miceLeft miceCaught |

miceAtGoal := self miceWithState: CmMouseState reachedGoal.
miceCaught := self miceWithState: CmMouseState caughtByCat.
miceLeft := CmSettings miceNumber - miceAtGoal - miceCaught.

scoreboardElem miceAtGoal: miceAtGoal.
scoreboardElem miceCaught: miceCaught.
scoreboardElem miceLeft: miceLeft.


]
