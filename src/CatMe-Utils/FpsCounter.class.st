Class {
	#name : #FpsCounter,
	#superclass : #Object,
	#instVars : [
		'frameCount',
		'lastFPSCalculationTime',
		'atLimit',
		'updateFPSClb'
	],
	#category : #'CatMe-Utils'
}

{ #category : #'as yet unclassified' }
FpsCounter class >> withFpsUpdateCallback: aBlock [
| obj | 

obj := FpsCounter new.
obj setFpsUpdateCallback: aBlock.

^ obj.

]

{ #category : #initialization }
FpsCounter >> initialize [ 

super initialize.

frameCount := 0.
lastFPSCalculationTime := Time millisecondClockValue.
atLimit := false

]

{ #category : #'as yet unclassified' }
FpsCounter >> measure: aBlock [
| startTime currentTime elapsedTime |

startTime := Time millisecondClockValue.

aBlock value.

frameCount := frameCount + 1.
currentTime := (Time millisecondClockValue).
elapsedTime := currentTime  - startTime.

"Check if a second has passed since the last FPS calculation"
(currentTime - lastFPSCalculationTime >= 500) ifTrue: [ 
	updateFPSClb value: frameCount * 2 value: atLimit.
	frameCount := 0.
	lastFPSCalculationTime := currentTime. 
	atLimit := false.
].
			
"Check elapsedTime was greater than wanted delay"
(CmSettings tickDelayMS < elapsedTime ) ifTrue: [ 
	atLimit := true. 
].			

^ elapsedTime

]

{ #category : #initialization }
FpsCounter >> setFpsUpdateCallback: aBlock [

updateFPSClb := aBlock
]
