Class {
	#name : #CmTunnel,
	#superclass : #Object,
	#instVars : [
		'exits',
		'isGoal'
	],
	#category : #'CatMe-Entities'
}

{ #category : #accessing }
CmTunnel >> exits [
^ exits
]

{ #category : #initialization }
CmTunnel >> initialize [
| numberOfExits |

isGoal := false.
exits := Set new.


numberOfExits := 2 + (Random new nextInteger: ((CmSettings maxTunnelEntries) - 2)).
1 to: numberOfExits do: [ :nr |
	| e |
	e := CmTunnelExit new.
	e tunnel: self.
	exits add: e. 
	].

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
