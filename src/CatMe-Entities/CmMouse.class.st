Class {
	#name : #CmMouse,
	#superclass : #CmCharacter,
	#instVars : [
		'inTunnel',
		'targetExit',
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
	self clipChildren: false.
	].
]

{ #category : #accessing }
CmMouse >> targetExit: anExit [
targetExit := anExit 
]

{ #category : #updating }
CmMouse >> update [

super update.

self moveTo: (targetExit position) 
	within: CmBoard boardLength asPoint 
	velocity: CmSettings mouseMovePerTick.

"debug mice"
CmSettings debugMice ifTrue: [ self updateDebugInfo. ].
]

{ #category : #debug }
CmMouse >> updateDebugInfo [
| str |

"
str := String streamContents: [ :stream |
	stream << 'pos: ' << self pos << '\n' << 
 ]
"

str := ''.
str := str, 'pos: ', self pos rounded asString, String cr.
str := str, 'target ', targetExit position rounded asString, String cr.

debugTextElem text: str asRopedText.
]
