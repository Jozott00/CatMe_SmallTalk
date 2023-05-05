"
# CmCharacter

Represents a Character entity
"
Class {
	#name : #CmCharacter,
	#superclass : #BlElement,
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

self position: self position + (aPoint * CmBoard catMovePerTick).


]

{ #category : #accessing }
CmCharacter >> moveBy: vectorPoint within: boundaryPoint [
"moves the character by a vector withing 0@0 and boundaryPoint"
   | newPosition |
    
   newPosition := self position + vectorPoint.
   newPosition := newPosition max: 0@0.
	newPosition := newPosition min: (boundaryPoint - self extent).
	
   self position: newPosition.

]

{ #category : #updating }
CmCharacter >> update [
]
