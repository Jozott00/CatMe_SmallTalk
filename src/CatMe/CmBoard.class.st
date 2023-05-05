"
I am the CatMe gameboard which holds the logic for a game round. I also represent a BlElement and therefore can be rendered.
"
Class {
	#name : #CmBoard,
	#superclass : #BlElement,
	#instVars : [
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
CmBoard class >> catMovePerTick [
^ 10
]

{ #category : #constants }
CmBoard class >> tickMS [
^ 1000 / 60 "60 fps"
]

{ #category : #initialization }
CmBoard >> initialize [ 

super initialize.
self initializeElementsAndAppearance.
self initializeInteractivity.
]

{ #category : #initialization }
CmBoard >> initializeElementsAndAppearance [
self size: self class boardLength asPoint.

cat := CmCat new.

self addChild: cat.
]

{ #category : #initialization }
CmBoard >> initializeInteractivity [

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
"executes all updates for a tick"

cat update.
]
