"
I am the CatMe gameboard which holds the logic for a game round. I also represent a BlElement and therefore can be rendered.
"
Class {
	#name : #CmBoard,
	#superclass : #BlElement,
	#instVars : [
		'actionController',
		'cat'
	],
	#category : #CatMe
}

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
