Class {
	#name : #CmDebugLine,
	#superclass : #BlElement,
	#instVars : [
		'e1',
		'e2',
		'lineGeometry'
	],
	#category : #'CatMe-Utils'
}

{ #category : #'instance creation' }
CmDebugLine class >> from: anElement to: anOtherElement [
| obj |
obj := CmDebugLine new.
obj element1: anElement.
obj element2: anElement.
obj build.
^ obj.
]

{ #category : #initialization }
CmDebugLine >> build [ 
| startPoint endPoint |
"self size: 1@1."

startPoint := e1 position + (e1 size / 2).
endPoint := e2 position + (e2 size / 2).

lineGeometry := BlLineGeometry new.

self geometry: lineGeometry.
self background: Color blue.
self size: 20@20
]

{ #category : #drawing }
CmDebugLine >> drawOn: aCanvas [
| startPoint endPoint |

Transcript show: 'test'.

startPoint := e1 globalPosition + (e1 size / 2).
endPoint := e2 globalPosition + (e2 size / 2).

lineGeometry from: startPoint to: endPoint.

aCanvas
	paint: (BlPaint new color: Color green);
	geometry: lineGeometry.
]

{ #category : #accessing }
CmDebugLine >> element1: anElement [
e1 := anElement 
]

{ #category : #accessing }
CmDebugLine >> element2: anElement [
e2 := anElement 
]
