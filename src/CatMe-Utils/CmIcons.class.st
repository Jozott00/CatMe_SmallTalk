"
I am a utility class that provides class side methods to load CatMe icons (cat, mouse, tunnel).
Additionally my method `asBlBackground:` converts a provided form to a BlBackground.

### Note: In order to work propally, the pharo image needs to include an iceberg repository named `CatMe_SmallTalk`. Otherwise I cannot find the icons in the resources directory.
"
Class {
	#name : #CmIcons,
	#superclass : #Object,
	#category : #'CatMe-Utils'
}

{ #category : #converting }
CmIcons class >> asBlBackground: aForm [
^ BlBackground builder 
	image
	form: aForm;
	build.
]

{ #category : #icons }
CmIcons class >> cat [
^ self loadIcon: 'cat.png'
]

{ #category : #utilities }
CmIcons class >> loadIcon: aString [
"loads image from resources directory of CatMe_SmallTalk repository"
| repository path form |
repository := IceRepository registry detect: [ :repo | repo name = 'CatMe_SmallTalk' ].
path := repository location / 'resources' / aString.
form := ImageReadWriter formFromFileNamed: path.
^form
]
