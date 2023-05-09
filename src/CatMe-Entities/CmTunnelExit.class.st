Class {
	#name : #CmTunnelExit,
	#superclass : #CmCharacter,
	#category : #'CatMe-Entities'
}

{ #category : #initialization }
CmTunnelExit >> initialize [
	| icon len |
	super initialize.
	icon := CmIcons tunnel.
	self background: (CmIcons asBlBackground: icon).
	len := 50.
	self size: len@len.
	
	self pos: CmUtils randomBoardPosition.
]
