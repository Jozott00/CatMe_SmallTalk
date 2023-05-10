"
I implement class side methods that return different settings.
"
Class {
	#name : #CmSettings,
	#superclass : #Object,
	#category : #CatMe
}

{ #category : #constants }
CmSettings class >> boardLength [
^ CmBoard boardLength.
]

{ #category : #'setting - cat' }
CmSettings class >> catMovePerTick [
^ 10.
]

{ #category : #debug }
CmSettings class >> debugFPS [
^ true
]

{ #category : #debug }
CmSettings class >> debugGoalTunnels [
^ false
]

{ #category : #debug }
CmSettings class >> debugMice [
"if true, position and target of mice are displayed"
^ false
]

{ #category : #debug }
CmSettings class >> debugTunnels [
"display tunnel ids"
^ false
]

{ #category : #'game-settings' }
CmSettings class >> findPathEveryXTicks [
^ 20
]

{ #category : #'game-settings' }
CmSettings class >> gameFPS [
^ 60
]

{ #category : #'game-settings' }
CmSettings class >> maxTunnelEntries [
^ 3
]

{ #category : #'setting - mice' }
CmSettings class >> miceMaxDelayCount [
^ self miceMaxDelayMS / self tickDelayMS
]

{ #category : #'setting - mice' }
CmSettings class >> miceMaxDelayMS [
"sets the mice delay in MS... is used by miceMaxDelayCount"
^ 1000 * 10
]

{ #category : #'setting - mice' }
CmSettings class >> miceMaxSpeed [
^ 3
]

{ #category : #'setting - mice' }
CmSettings class >> miceNumber [
^ 50
]

{ #category : #'setting - mice' }
CmSettings class >> miceTrace [
^ false
]

{ #category : #'setting - mice' }
CmSettings class >> mouseMovePerTick [
^ 1
]

{ #category : #'game-settings' }
CmSettings class >> startupDelay [
^ 200
]

{ #category : #'game-settings' }
CmSettings class >> tickDelayMS [
^ 1000 / self gameFPS 
]

{ #category : #'game-settings' }
CmSettings class >> tunnelNumber [
^10
]
