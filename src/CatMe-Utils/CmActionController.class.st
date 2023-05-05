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

{ #category : #action }
CmActionController >> directionPoint [
"returns a vector as `Point` dependening on what arrowkeys where pressed"
    | x y keys |
    x := 0.
    y := 0.
	
	 "copy keys to get consistent state"
	 keys := pressedKeys copy.
	
    "Check if the left arrow key is pressed"
    (keys includes: KeyboardKey left ) ifTrue: [ x := x - 1 ].

    "Check if the right arrow key is pressed"
    (keys includes: KeyboardKey right ) ifTrue: [ x := x + 1 ].

    "Check if the up arrow key is pressed"
    (keys includes: KeyboardKey up ) ifTrue: [ y := y - 1 ].

    "Check if the down arrow key is pressed"
    (keys includes: KeyboardKey down ) ifTrue: [ y := y + 1 ].

    "Return a Point representing the direction vector"
    ^ x@y
]

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

pressedKeys add: aKeyDownEvent key.
]

{ #category : #'key-updates' }
CmActionController >> onKeyUp [
^ [ :evt | self onKeyUp: evt ]
]

{ #category : #'key-updates' }
CmActionController >> onKeyUp: aKeyUpEvent [

pressedKeys remove: aKeyUpEvent key.
]

{ #category : #accessing }
CmActionController >> pressedKeys [
^ pressedKeys 
]
