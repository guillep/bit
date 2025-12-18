Class {
	#name : 'BITStopReplay',
	#superclass : 'Object',
	#instVars : [
		'session',
		'realObject'
	],
	#category : 'BIT',
	#package : 'BIT'
}

{ #category : 'as yet unclassified' }
BITStopReplay >> haltMaybe [

	<debuggerCompleteToSender>
	session stopRecording.
	^ realObject
]

{ #category : 'accessing' }
BITStopReplay >> realObject [

	^ realObject
]

{ #category : 'accessing' }
BITStopReplay >> realObject: anObject [

	realObject := anObject
]

{ #category : 'accessing' }
BITStopReplay >> session [

	^ session
]

{ #category : 'accessing' }
BITStopReplay >> session: anObject [

	session := anObject
]
