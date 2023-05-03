"
#The Cat Me If You Can App class

This class is the entry point for the cat me if you can game
"
Class {
	#name : #CatMeGame,
	#superclass : #Object,
	#instVars : [
		'myArg'
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

{ #category : #'as yet unclassified' }
CatMeGame class >> withArg: someArg [
	self initialize.
	myArg := someArg. 
]

{ #category : #initialization }
CatMeGame >> initializeWithArgs: someArg [
	self initialize .
	myArg := someArg 
]
