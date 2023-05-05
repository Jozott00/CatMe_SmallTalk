"
I am a keystroke handler that stores currently pressed keystrokes.
Additionally I provide some methods that makes it easy for users to determine specific useractions, such as the movement direction.
"
Class {
	#name : #CmActionController,
	#superclass : #Object,
	#instVars : [
		'pressedKeys'
	],
	#category : #'CatMe-Utils'
}

{ #category : #initialization }
CmActionController >> initialize [
pressedKeys := Set new.
]

{ #category : #'key-updates' }
CmActionController >> onKeyDown [
"returns a block that takes a BlKeyDownEvent"
^ [ :evt | self onKeyDown: evt ]
]

{ #category : #'key-updates' }
CmActionController >> onKeyDown: aKeyDownEvent [
self inform: 'Key down: ', aKeyDownEvent asString.

pressedKeys add: aKeyDownEvent key.
]

{ #category : #'key-updates' }
CmActionController >> onKeyUp [
^ [ :evt | self onKeyUp: evt ]
]

{ #category : #'key-updates' }
CmActionController >> onKeyUp: aKeyUpEvent [
self inform: 'Key down: ', aKeyUpEvent asString.

pressedKeys add: aKeyUpEvent key.
]

{ #category : #accessing }
CmActionController >> pressedKeys [
^ pressedKeys 
]
