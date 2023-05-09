Class {
	#name : #CmScoreBoard,
	#superclass : #BlElement,
	#instVars : [
		'miceLeftElem',
		'miceAtGoalElem'
	],
	#category : #CatMe
}

{ #category : #initialization }
CmScoreBoard >> initialize [

super initialize.

self initializeAppearance.
self initializeMiceElements.
]

{ #category : #initialization }
CmScoreBoard >> initializeAppearance [ 
| border |

border := BlBorder builder
	paint: Color black;
	width: 2;
	capRound;
	build.

self border: border.
self position: CmBoard boardLength asPoint - (200@100).
self size: 200@100.
self background: Color white.
]

{ #category : #initialization }
CmScoreBoard >> initializeMiceElements [

miceLeftElem := BlTextElement new
			text: 'Mice Left: ...' asRopedText;
			position: 10@10;
			defaultFontSize: 20.
			
miceAtGoalElem := BlTextElement new
			text: 'Mice at Goal: ...' asRopedText;
			position: 10@30;
			defaultFontSize: 20.
			
self addChildren: { miceLeftElem . miceAtGoalElem }.

]

{ #category : #update }
CmScoreBoard >> miceAtGoal: aNumber [
miceAtGoalElem text: ('Mice at Goal: ', aNumber asString) asRopedText.
]

{ #category : #update }
CmScoreBoard >> miceLeft: aNumber [

miceLeftElem text: ('Mice Left: ', aNumber asString) asRopedText.
]
