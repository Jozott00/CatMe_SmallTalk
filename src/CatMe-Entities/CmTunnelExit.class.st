Class {
	#name : #CmTunnelExit,
	#superclass : #CmCharacter,
	#instVars : [
		'tunnel'
	],
	#category : #'CatMe-Entities'
}

{ #category : #accessing }
CmTunnelExit class >> position: aPoint tunnel: aTunnel [
| obj |
obj := self new.
obj pos: aPoint.
obj tunnel: aTunnel.
^ obj.
]

{ #category : #initialization }
CmTunnelExit >> initialize [
	| icon len |
	super initialize.
	icon := CmIcons tunnel.
	self background: (CmIcons asBlBackground: icon).
	len := 50.
	self size: len@len.
	
	"self pos: CmUtils randomBoardPosition."
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
