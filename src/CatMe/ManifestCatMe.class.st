"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCatMe,
	#superclass : #PackageManifest,
	#category : #'CatMe-Manifest'
}

{ #category : #'code-critics' }
ManifestCatMe class >> ruleGuardingClauseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#CmBoard #initializeDebugInfo #false)) #'2023-05-09T21:33:17.252921+02:00') )
]

{ #category : #'code-critics' }
ManifestCatMe class >> ruleReGuardClauseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#CmBoard #initializeDebugInfo #false)) #'2023-05-09T21:33:14.407851+02:00') )
]
