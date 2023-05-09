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
^ true
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
^ 20
]

{ #category : #'game-settings' }
CmSettings class >> mouseMovePerTick [
^ 1
]
