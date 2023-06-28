"
#The Cat Me If You Can App class

This class is the entry point for the cat me if you can game
"
Class {
	#name : #CatMeGame,
	#superclass : #BlElement,
	#instVars : [
		'window',
		'isRunning'
	],
	#classInstVars : [
		'myArg'
	],
	#category : #CatMe
}

{ #category : #accessing }
CatMeGame class >> myArg: aString [
	myArg := aString
]

{ #category : #'instance creation' }
CatMeGame class >> newWithArgs: someArg [
	| newObj |
	newObj := self new.
	newObj initialize.
	newObj myArg: someArg.
	^ newObj 
	
]

{ #category : #initialization }
CatMeGame >> initialize [ 

super initialize.

self initializeAppearance.
]

{ #category : #initialization }
CatMeGame >> initializeAppearance [

window := BlSpace new.
window extent: CmSettings boardLength asPoint.
window addEventHandlerOn: BlSpaceClosedEvent
	do: [ self inform: 'Space closed'. self stop. ].
]

{ #category : #'as yet unclassified' }
CatMeGame >> showEndScreen [
| endscreen |

endscreen := CmEndScreen withCloseCallback: [
		window close.
	].

window root removeChildren.

window root 
	addChild: endscreen.
	

	
]

{ #category : #'game - logic' }
CatMeGame >> start [
| board |

board := CmBoard new.
window root addChild: board.
isRunning := true.

window show.

[ 
	| fpsCounter|
	(Delay forMilliseconds: CmSettings startupDelay) wait.
	
	fpsCounter := FpsCounter withFpsUpdateCallback: [:fcount :atlimit | board updateFPS: fcount atLimit: atlimit ]. 
	
	[ isRunning  ] whileTrue: [ 
		| elapsedTime |
	
		elapsedTime := fpsCounter measure: [ 
			self tick: board.
		].
			
		(Delay forMilliseconds: (CmSettings tickDelayMS - elapsedTime max: 0)) wait.
	].

	board updateScoreboard.
	self showEndScreen.
	self inform: 'Game round stopped'.
	"window close."
	
	
] fork.
]

{ #category : #'game - logic' }
CatMeGame >> stop [

isRunning := false.
]

{ #category : #'game - logic' }
CatMeGame >> tick: aBoard [

aBoard update.

aBoard isFinishState ifTrue: [ self stop ]
]
