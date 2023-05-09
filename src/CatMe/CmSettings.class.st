"
I implement class side methods that return different settings.
"
Class {
	#name : #CmSettings,
	#superclass : #Object,
	#category : #CatMe
}

{ #category : #debug }
CmSettings class >> debugGoalTunnels [
^true
]

{ #category : #debug }
CmSettings class >> debugMice [
"if true, position and target of mice are displayed"
^ false
]

{ #category : #debug }
CmSettings class >> debugTunnels [
"display tunnel ids"
^true
]

{ #category : #hide }
CmSettings class >> hideMice [
^false
]

{ #category : #'game-settings' }
CmSettings class >> miceNumber [
^ 1
]

{ #category : #'game-settings' }
CmSettings class >> mouseMovePerTick [
^ 10
]

{ #category : #'game-settings' }
CmSettings class >> startupDelay [
^ 200
]
