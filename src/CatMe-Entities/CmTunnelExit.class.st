Class {
	#name : #CmTunnelExit,
	#superclass : #CmCharacter,
	#instVars : [
		'isGoal'
	],
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
	self isGoal: false.
]

{ #category : #accessing }
CmTunnelExit >> isGoal [
^isGoal
]

{ #category : #accessing }
CmTunnelExit >> isGoal: aBoolean [
isGoal := aBoolean
]
