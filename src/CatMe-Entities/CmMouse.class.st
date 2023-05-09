Class {
	#name : #CmMouse,
	#superclass : #CmCharacter,
	#instVars : [
		'inTunnel',
		'atGoal',
		'targetExit',
		'delayCounter',
		'nextTargetClb',
		'debugTextElem'
	],
	#category : #'CatMe-Entities'
}

{ #category : #accessing }
CmMouse >> atGoal [
^ atGoal
]

{ #category : #'game-logic' }
CmMouse >> delayDecrement [
delayCounter := delayCounter - 1.
]

{ #category : #'game-logic' }
CmMouse >> hides [
^ inTunnel
]

{ #category : #accessing }
CmMouse >> inTunnel: aBoolean [
| invisibleOpacity |
inTunnel := aBoolean.

invisibleOpacity := 0.
CmSettings miceTrace ifTrue: [ invisibleOpacity := 0.3 ].

aBoolean ifFalse: [ self opacity: 1 ] ifTrue: [ self opacity: invisibleOpacity ]
]

{ #category : #accessing }
CmMouse >> initialExit: anExit [
self pos: anExit pos.
targetExit := anExit 
]

{ #category : #initialization }
CmMouse >> initialize [ 

super initialize.
atGoal := false.
delayCounter := CmSettings miceMaxDelayCount atRandom.
self speed: CmSettings miceMaxSpeed atRandom * CmSettings mouseMovePerTick.
self inTunnel: true.
self initializeAppearance 
]

{ #category : #initialization }
CmMouse >> initializeAppearance [
| icon |

icon := CmIcons mouse.
self background: (CmIcons asBlBackground: icon).

CmSettings debugMice ifTrue: [ 
	debugTextElem := BlTextElement text: 'hello ' asRopedText.
 	self addChild: debugTextElem.
	self clipChildren: true.
	].
]

{ #category : #accessing }
CmMouse >> nextTargetClb: aBlockClosure [
nextTargetClb := aBlockClosure.
]

{ #category : #updating }
CmMouse >> update [
| reachedTarget |

super update.

"decrement delay"
delayCounter > 0 ifTrue: [ ^ self delayDecrement ].

atGoal ifTrue: [ ^nil ].

"move in target direction"
reachedTarget := self moveTo: (targetExit position) 
	within: CmBoard boardLength asPoint 
	velocity: speed.


"if target is reached and target is not goal, get next target"
reachedTarget ifTrue: [ 	
		| oldTarget |
		targetExit isGoal ifTrue: [ 
			atGoal := true.
			self inTunnel: true.
		] ifFalse: [ 
		
		"get new target"
		oldTarget := targetExit.
		targetExit := nextTargetClb value: targetExit.
		
		self inTunnel: ((oldTarget tunnel) = (targetExit tunnel)).
	] 
].

"debug mice"
CmSettings debugMice ifTrue: [ self updateDebugInfo. ].
]

{ #category : #debug }
CmMouse >> updateDebugInfo [
| str |


str := String streamContents: [ :stream |
	stream << 'pos: ' << self pos asString << '|' << 'target ' << targetExit position rounded asString.
 ].

"
str := ''.
str := str, 'pos: ', self pos rounded asString, String cr.
str := str, 'target ', targetExit position rounded asString, String cr.
"

debugTextElem text: str asRopedText.
]
