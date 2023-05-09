"
# CmCharacter

Represents a Character entity
"
Class {
	#name : #CmCharacter,
	#superclass : #BlElement,
	#instVars : [
		'pos',
		'speed'
	],
	#category : #'CatMe-Entities'
}

{ #category : #accessing }
CmCharacter class >> position: aPosition [
	| obj |
	obj := self new.
	obj position: aPosition. 
	^ obj.
	
]

{ #category : #accessing }
CmCharacter >> moveBy: aPoint [

self pos: self pos + (aPoint * CmBoard catMovePerTick).


]

{ #category : #accessing }
CmCharacter >> moveBy: vectorPoint within: boundaryPoint [
"moves the character by a vector withing 0@0 and boundaryPoint"
   | newPosition |
    
   newPosition := self pos + vectorPoint.
   newPosition := newPosition max: 0@0.
	newPosition := newPosition min: (boundaryPoint - self extent).
	
	"don't update position if not necassary, since this causes rendering"
	(newPosition = (0@0)) ifTrue: [ ^ nil ].
	
   self pos: newPosition.

]

{ #category : #accessing }
CmCharacter >> moveTo: aPoint within: boundaryPoint velocity: aNumber [
"returns true if aPoint was reached"

| direction finalMovement reached |

"calculate direction"
direction := aPoint - self pos.
finalMovement := 0@0.
(direction = (0@0)) ifFalse: [ finalMovement := direction normalized ].
finalMovement := finalMovement * aNumber.

reached := direction abs <= finalMovement abs.
reached ifTrue: [ finalMovement := direction ].

self moveBy: finalMovement within: boundaryPoint.

^ reached.
]

{ #category : #accessing }
CmCharacter >> pos [
^ pos
]

{ #category : #accessing }
CmCharacter >> pos: aPoint [
self position: aPoint.
pos := aPoint.
]

{ #category : #accessing }
CmCharacter >> speed [
^ speed.
]

{ #category : #accessing }
CmCharacter >> speed: aNumber [
speed := aNumber
]

{ #category : #updating }
CmCharacter >> update [
]
