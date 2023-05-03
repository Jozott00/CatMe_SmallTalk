"
# CmCharacter

Represents a Character entity
"
Class {
	#name : #CmCharacter,
	#superclass : #Object,
	#instVars : [
		'position'
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
CmCharacter >> position [
	^ position 
]

{ #category : #accessing }
CmCharacter >> position: aPosition [
	position := aPosition 
]
