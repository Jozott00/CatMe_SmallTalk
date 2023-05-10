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

{ #category : #'game - logic' }
CatMeGame >> start [
| board |

board := CmBoard new.
window root addChild: board.
isRunning := true.

window show.

[ 
	| frameCount lastFPSCalculationTime atLimit|
	(Delay forMilliseconds: CmSettings startupDelay) wait.
	
	frameCount := 0.
	lastFPSCalculationTime := Time millisecondClockValue.
	atLimit := false.
	
	[ isRunning  ] whileTrue: [ 
		| startTime currentTime elapsedTime |
		startTime := Time millisecondClockValue.
	
		self tick: board.
		
		frameCount := frameCount + 1.
		currentTime := Time millisecondClockValue.
		elapsedTime := currentTime - startTime.
		
		"Check if a second has passed since the last FPS calculation"
		(currentTime - lastFPSCalculationTime >= 500) ifTrue: [ 
			board updateFPS: frameCount * 2 atLimit: atLimit.
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

	board updateScoreboard.
	self inform: 'Game round stopped'.
	window close.
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
