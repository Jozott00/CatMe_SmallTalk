Class {
	#name : #CmEndScreen,
	#superclass : #BlElement,
	#instVars : [
		'closeCallBack'
	],
	#category : #CatMe
}

{ #category : #initialization }
CmEndScreen class >> withCloseCallback: aBlock [
| obj |

obj := CmEndScreen new.
obj initialize.
obj setCloseCallback: aBlock.
^ obj
]

{ #category : #initialization }
CmEndScreen >> initialize [

super initialize.
self initializeAppearance.
]

{ #category : #initialization }
CmEndScreen >> initializeAppearance [ 


self size: CmSettings boardLength asPoint.

self layout: (BlLinearLayout vertical alignCenter; cellSpacing: 20).
self addChildren: {
	BlTextElement new
	text: 'Game Ended!' asRopedText;
	defaultFontSize: 20.
	BlTextElement new
	text: 'Press `q` to close.' asRopedText;
	defaultFontSize: 20
}.

self addEventHandlerOn:  BlKeyDownEvent do: [ :evt |
		(evt key name = 'Q') ifTrue: [
			closeCallBack value.
		]
	].

self requestFocus.
]

{ #category : #initialization }
CmEndScreen >> setCloseCallback: aBlock [
closeCallBack := aBlock
]
