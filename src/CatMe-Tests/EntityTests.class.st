Class {
	#name : #EntityTests,
	#superclass : #TestCase,
	#category : #'CatMe-Tests'
}

{ #category : #vector }
EntityTests >> testAddition [
	| op1 op2 result |
	op1 := CmVector x: 2 y: -1.
	op2 := CmVector x: 9 y: 3.
	result := op1 + op2.
	self assert: result equals: (CmVector x: 11 y: 2)
]

{ #category : #vector }
EntityTests >> testEquality [
    | vector1 vector2 vector3 |
    vector1 := CmVector x: 1 y: 2.
    vector2 := CmVector x: 1 y: 2.
    vector3 := CmVector x: 3 y: 4.

    self assert: vector1 equals: vector2.
    self deny: vector1 equals: vector3.

]

{ #category : #tests }
EntityTests >> testSubstraction [
	| op1 op2 result |
	op1 := CmVector x: 2 y: -1.
	op2 := CmVector x: 9 y: 3.
	result := op1 - op2.
	self assert: result equals: (CmVector x: -7 y: -4)
]
