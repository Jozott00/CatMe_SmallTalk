Class {
	#name : #CmScoreBoard,
	#superclass : #BlElement,
	#instVars : [
		'miceLeft',
		'miceAtGoal',
		'miceCaught',
		'miceLeftElem',
		'miceAtGoalElem',
		'miceCaughtElem'
	],
	#category : #CatMe
}

{ #category : #initialization }
CmScoreBoard >> initialize [

super initialize.

miceLeft := '...'.
miceAtGoal := '...'.
miceCaught := '...'.

self initializeAppearance.
self updateElements.
]

{ #category : #initialization }
CmScoreBoard >> initializeAppearance [ 
| border |

border := BlBorder builder 
	paint: Color black;
	capRound;
	build.

self layout: (BlLinearLayout vertical alignTopLeft; cellSpacing: 5).
self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent
	 ].
self padding: (BlInsets all: 20).
self clipChildren: false.
self border: border.
"self position: CmBoard boardLength asPoint."
self background: Color white.
]

{ #category : #update }
CmScoreBoard >> miceAtGoal: aNumber [

(miceAtGoal = aNumber) ifTrue: [ ^ nil ].

miceAtGoal := aNumber.
self updateElements.
]

{ #category : #update }
CmScoreBoard >> miceCaught: aNumber [

(miceCaught = aNumber) ifTrue: [ ^ nil ].

miceCaught := aNumber.
self updateElements.
]

{ #category : #update }
CmScoreBoard >> miceLeft: aNumber [

(miceLeft = aNumber) ifTrue: [ ^ nil ].

miceLeft := aNumber.
self updateElements.
]

{ #category : #initialization }
CmScoreBoard >> updateElements [

self removeChildren.

miceLeftElem := BlTextElement new
			text: ('Mice Left: ', miceLeft asString) asRopedText;
			position: 10@10;
			defaultFontSize: 20.
			
miceAtGoalElem := BlTextElement new
			text: ('Mice at Goal: ', miceAtGoal asString) asRopedText;
			position: 10@30;
			defaultFontSize: 20.
			
miceCaughtElem := BlTextElement new
			text: ('Mice Caught: ', miceCaught asString) asRopedText;
			position: 10@50;
			defaultFontSize: 20.
			
self addChildren: { miceLeftElem . miceAtGoalElem . miceCaughtElem }.

]
