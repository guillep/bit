Class {
	#name : 'BITHalter',
	#superclass : 'BITStopReplay',
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
	super haltMaybe.
	self halt.
	^ realObject
]
