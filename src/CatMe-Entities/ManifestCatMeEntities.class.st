"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCatMeEntities,
	#superclass : #PackageManifest,
	#category : #'CatMe-Entities-Manifest'
}

{ #category : #'code-critics' }
ManifestCatMeEntities class >> ruleGuardingClauseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#CmMouse #initializeAppearance #false)) #'2023-05-09T16:35:56.476539+02:00') )
]

{ #category : #'code-critics' }
ManifestCatMeEntities class >> ruleNoClassCommentRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'CatMe-Entities')) #'2023-05-03T19:39:20.866041+02:00') )
]

{ #category : #'code-critics' }
ManifestCatMeEntities class >> ruleReGuardClauseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#CmMouse #initializeAppearance #false)) #'2023-05-09T16:36:05.437824+02:00') )
]
