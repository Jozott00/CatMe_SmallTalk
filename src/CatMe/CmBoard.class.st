"
I am the CatMe gameboard which holds the logic for a game round. I also represent a BlElement and therefore can be rendered.
"
Class {
	#name : #CmBoard,
	#superclass : #BlElement,
	#instVars : [
		'actionController',
		'isRunning',
		'cat'
	],
	#category : #CatMe
}

{ #category : #constants }
CmBoard class >> boardLength [
^500
]

{ #category : #constants }
CmBoard class >> movementPerTick [
^2
]

{ #category : #constants }
CmBoard class >> tickMS [
^ 20
]

{ #category : #accessing }
CmBoard >> actionController [
	^ actionController 
]

{ #category : #initialization }
CmBoard >> initialize [ 

super initialize.

actionController := CmActionController new.

self initializeElementsAndAppearance.
self initializeInteractivity.
]

{ #category : #initialization }
CmBoard >> initializeElementsAndAppearance [
self size: self class boardLength asPoint.

cat := BlElement new
	background: (CmIcons asBlBackground: CmIcons cat).

self addChild: cat.
]

{ #category : #initialization }
CmBoard >> initializeInteractivity [

cat addEventHandlerOn: BlKeyDownEvent do: actionController onKeyDown.
cat addEventHandlerOn: BlKeyUpEvent do: actionController onKeyUp. 
cat requestFocus.
]

{ #category : #'game-logic' }
CmBoard >> start [

isRunning := true.
[ 
	[ isRunning  ] whileTrue: [ 
		self tick.
		(Delay forMilliseconds: self class tickMS) wait.
	 ].
	
	self inform: 'Game round stopped'
] fork.
]

{ #category : #'game-logic' }
CmBoard >> stop [
isRunning := false
]

{ #category : #'game-logic' }
CmBoard >> tick [
| movement |

movement := actionController directionPoint.
cat position: cat position + (movement * self class movementPerTick).
]
