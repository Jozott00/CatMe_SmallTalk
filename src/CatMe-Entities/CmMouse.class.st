Class {
	#name : #CmMouse,
	#superclass : #CmCharacter,
	#instVars : [
		'inTunnel',
		'targetExit',
		'nextTargetClb',
		'debugTextElem'
	],
	#category : #'CatMe-Entities'
}

{ #category : #'game-logic' }
CmMouse >> hides [
^ inTunnel
]

{ #category : #initialization }
CmMouse >> initialize [ 

super initialize.
self initializeAppearance 
]

{ #category : #initialization }
CmMouse >> initializeAppearance [
| icon |

icon := CmIcons mouse.
self background: (CmIcons asBlBackground: icon).
self pos: CmUtils randomBoardPosition.

CmSettings hideMice ifTrue: [ self opacity: 0 ].

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

{ #category : #accessing }
CmMouse >> targetExit: anExit [
targetExit := anExit 
]

{ #category : #updating }
CmMouse >> update [
| reachedTarget |

super update.

reachedTarget := self moveTo: (targetExit position) 
	within: CmBoard boardLength asPoint 
	velocity: CmSettings mouseMovePerTick.


reachedTarget ifTrue: [ 
	"get new target"
	targetExit := nextTargetClb value: targetExit.	
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
