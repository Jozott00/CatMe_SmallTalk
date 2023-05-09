Class {
	#name : #CmTunnelExit,
	#superclass : #CmCharacter,
	#instVars : [
		'tunnel'
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
]

{ #category : #accessing }
CmTunnelExit >> isGoal [
^ tunnel isGoal 
]

{ #category : #accessing }
CmTunnelExit >> tunnel [
^ tunnel.
]

{ #category : #accessing }
CmTunnelExit >> tunnel: aTunnel [
tunnel := aTunnel
]
