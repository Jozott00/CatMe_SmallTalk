"
# Cat Class

Represents the cat in the game
"
Class {
	#name : #CmCat,
	#superclass : #CmCharacter,
	#instVars : [
		'actionController'
	],
	#category : #'CatMe-Entities'
}

{ #category : #initialization }
CmCat >> initialize [

super initialize.

actionController := CmActionController new.
self initializeAppearance.
self initializeInteractivity.
]

{ #category : #initialization }
CmCat >> initializeAppearance [
| icon |

icon := CmIcons cat.
self background: (CmIcons asBlBackground: icon).
self pos: CmUtils randomBoardPosition.

]

{ #category : #initialization }
CmCat >> initializeInteractivity [

self addEventHandlerOn: BlKeyDownEvent do: actionController onKeyDown.
self addEventHandlerOn: BlKeyUpEvent do: actionController onKeyUp. 
self requestFocus.
]

{ #category : #updating }
CmCat >> update [
| movement |

super update.

movement := actionController directionPoint * CmBoard catMovePerTick.
self moveBy: movement within: CmBoard boardLength asPoint.
]
