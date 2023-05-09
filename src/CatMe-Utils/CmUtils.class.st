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
