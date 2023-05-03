Class {
	#name : #CmVector,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#classInstVars : [
		'x',
		'y'
	],
	#category : #'CatMe-Entities'
}

{ #category : #'instance creation' }
CmVector class >> x: aX y: aY [
	| obj |
	obj := self new.
	obj x: aX y: aY.
	^ obj
]

{ #category : #accessing }
CmVector >> x [
	^y
]

{ #category : #'instance creation' }
CmVector >> x: aX y: aY [
	x := aX.
	y := aY.
]

{ #category : #accessing }
CmVector >> y [
	^y
]
