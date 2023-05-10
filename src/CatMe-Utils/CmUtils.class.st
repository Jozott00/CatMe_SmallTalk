Class {
	#name : #CmUtils,
	#superclass : #Object,
	#category : #'CatMe-Utils'
}

{ #category : #random }
CmUtils class >> randomBoardPosition [
	| randomX randomY |
	"generate position"
	randomX := (0 to: CmBoard boardLength - 50) atRandom.
	randomY := (0 to: CmBoard boardLength - 50) atRandom.
	
	^ randomX@randomY
]

{ #category : #random }
CmUtils class >> randomBoardPositionCount: aCountNumber spacing: aSpacingNumber [
"Generates aCountNumber Points with `self randomBoardPosition`,
where each position got a spacing between all other of atleast aSpacingNumber"
    | positions position |
    positions := OrderedCollection new.

    aCountNumber timesRepeat: [
        [ position := self randomBoardPosition.
        (positions anySatisfy: [ :p | (p distanceTo: position) < aSpacingNumber ]) ] whileTrue.
        positions add: position ].

    ^ positions
]

{ #category : #random }
CmUtils class >> randomExitPositions: aCountNumber notIn: aSet spacing: aSpacingNumber [
 | positions position |
 positions := OrderedCollection new.

 aCountNumber timesRepeat: [
      [position := self randomBoardPosition.
      		(aSet anySatisfy: [ :p | (p distanceTo: position) < aSpacingNumber ]) ] whileTrue.
      positions add: position. 
		aSet add: position 
		].

  ^ positions
]
