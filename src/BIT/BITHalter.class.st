Class {
	#name : 'BITHalter',
	#superclass : 'Object',
	#instVars : [
		'realObject',
		'session'
	],
	#category : 'BIT',
	#package : 'BIT'
}

{ #category : 'instance creation' }
BITHalter class >> on: aRealObject [

	^ self new
		realObject: aRealObject;
		yourself
]

{ #category : 'as yet unclassified' }
BITHalter >> haltMaybe [
	<debuggerCompleteToSender>
	session stopRecording.
	self halt.
	^ realObject
]

{ #category : 'accessing' }
BITHalter >> realObject [

	^ realObject
]

{ #category : 'accessing' }
BITHalter >> realObject: anObject [

	realObject := anObject
]

{ #category : 'accessing' }
BITHalter >> session [

	^ session
]

{ #category : 'accessing' }
BITHalter >> session: anObject [

	session := anObject
]
