Class {
	#name : #CmMouseState,
	#superclass : #Object,
	#classVars : [
		'CaughtByCat',
		'InGame',
		'ReachedGoal',
		'initialized'
	],
	#category : #'CatMe-Entities'
}

{ #category : #accessing }
CmMouseState class >> caughtByCat [

self initialize.
^ CaughtByCat
]

{ #category : #accessing }
CmMouseState class >> inGame [
self initialize.

^ InGame
]

{ #category : #'class initialization' }
CmMouseState class >> initialize [

initialized ifNotNil: [ ^ nil. ].
initialized := true.

CaughtByCat := 1.
ReachedGoal := 2.
InGame := 3.
]

{ #category : #accessing }
CmMouseState class >> reachedGoal [

self initialize.
^ ReachedGoal
]
