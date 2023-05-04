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

{ #category : #arithmetic }
CmVector >> * aDouble [
	^ self scaledBy: aDouble
]

{ #category : #arithmetic }
CmVector >> + aVector [
	^ self addedTo: aVector 
]

{ #category : #arithmetic }
CmVector >> - aVector [
	^ self substractedFrom: aVector 

]

{ #category : #calculating }
CmVector >> addedTo: aVector [
	^ self class x: x + (aVector x) y: y + (aVector y)
]

{ #category : #calculating }
CmVector >> length [ 
	^ ((x * x) + (y * y)) sqrt 
]

{ #category : #calculating }
CmVector >> normalized [ 
	| len |
	len := self length.
	^ self class x: x / len y: y / len
]

{ #category : #calculating }
CmVector >> scaledBy: aDouble [
	"Returns new vector that is scaled by the given double"
	^ self class x: x * aDouble y: y * aDouble
]

{ #category : #calculating }
CmVector >> substractedFrom: aVector [
	^ self class x: x - aVector x y: y - aVector y
]

{ #category : #accessing }
CmVector >> x [
	^x
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
