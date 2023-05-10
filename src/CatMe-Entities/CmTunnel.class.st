Class {
	#name : #CmTunnel,
	#superclass : #Object,
	#instVars : [
		'exits',
		'isGoal'
	],
	#category : #'CatMe-Entities'
}

{ #category : #initalize }
CmTunnel class >> exitPositionGenerator: aBlockClosure [
| obj |
obj := self new.
obj initializeExitsWith: aBlockClosure.
^ obj.
]

{ #category : #accessing }
CmTunnel >> exits [
^ exits
]

{ #category : #initialization }
CmTunnel >> initialize [
isGoal := false.
exits := Set new.


]

{ #category : #initialization }
CmTunnel >> initializeExitsWith: aBlockClosure [
"aBlockClosure can be called to get a new position for an exit"
| numberOfExits exitPositions |

numberOfExits := 2 + (Random new nextInteger: ((CmSettings maxTunnelEntries) - 2)).
exitPositions := aBlockClosure value: numberOfExits.

"create exit positions"
exits addAll: (exitPositions collect: [ :pos |
	CmTunnelExit 
			position: pos
			tunnel: self. 
	]).

self updateAppearance.
]

{ #category : #accessing }
CmTunnel >> isGoal [
^isGoal 
]

{ #category : #accessing }
CmTunnel >> isGoal: aBoolean [
isGoal := aBoolean.

self updateAppearance. 
]

{ #category : #appearance }
CmTunnel >> updateAppearance [

exits do: [ :e |
	
		"show tunnel and exit ids"
		CmSettings debugTunnels ifTrue: [
		| text |
		
		text := String streamContents: [ :stream | 
			stream << self basicIdentityHash asString << ' - ' << e hash asString ].
		e clipChildren: false.
		e addChild: (BlTextElement new
			text: text asRopedText).  
		].	
		
		"show goal tunnels"
		(CmSettings debugGoalTunnels & isGoal) ifTrue: [ 
			| border |
			border := BlBorder builder
				paint: Color blue; 
				width: 2;
				build.

			e border: border.				
		].
		
	 ]

]
