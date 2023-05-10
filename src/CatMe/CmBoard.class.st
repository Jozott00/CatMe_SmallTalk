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
		'pathFinder',
		'lastKnownCatPos',
		'dijkstraGraph',
		'tickCount',
		'fpsElement',
		'scoreboardElem'
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

{ #category : #initialization }
CmBoard >> initialize [ 

super initialize.

tickCount := 0.
tunnels := Set new.
mice := Set new.

self initializeElementsAndAppearance.
self initializePathfinder.
"self initializeMouseRunningPaths."

self initializeDebugInfo.
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

"generate cat"
cat := CmCat new.
self addChild: cat.

"scoreboard"
scoreboardElem := CmScoreBoard new.
self addChild: scoreboardElem.

]

{ #category : #initialization }
CmBoard >> initializePathfinder [

pathFinder := CmPathfinder tunnels: tunnels.
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

{ #category : #'game-logic' }
CmBoard >> start [

isRunning := true.
[ 
	| frameCount lastFPSCalculationTime atLimit|
	(Delay forMilliseconds: CmSettings startupDelay) wait.
	
	"start first path calculation"
	pathFinder rerun.
	
	frameCount := 0.
	lastFPSCalculationTime := Time millisecondClockValue.
	atLimit := false.
	
	[ isRunning  ] whileTrue: [ 
		| startTime currentTime elapsedTime |
		startTime := Time millisecondClockValue.
	
		self tick.
		
		frameCount := frameCount + 1.
		tickCount := tickCount + 1.
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

	self updateScoreboard.
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

"check if game is finished"
self isFinishState ifTrue: [ self stop ]
]

{ #category : #accessing }
CmBoard >> tunnels [
^ tunnels
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
