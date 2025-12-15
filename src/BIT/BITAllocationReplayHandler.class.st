Class {
	#name : 'BITAllocationReplayHandler',
	#superclass : 'MpHandler',
	#instVars : [
		'allocationStream'
	],
	#category : 'BIT',
	#package : 'BIT'
}

{ #category : 'instance creation' }
BITAllocationReplayHandler class >> newOn: allocationList [

	^ self new
		allocationStream: allocationList readStream;
		yourself
]

{ #category : 'accessing' }
BITAllocationReplayHandler >> afterExecutionWithReceiver: anObject arguments: anArrayOfObjects returnValue: returnValue [
	<debuggerCompleteToSender>
	"Ignore the allocated object. Replay the old one!"
	^ allocationStream next haltMaybe
]

{ #category : 'accessing' }
BITAllocationReplayHandler >> allocationStream [

	^ allocationStream
]

{ #category : 'accessing' }
BITAllocationReplayHandler >> allocationStream: anObject [

	allocationStream := anObject
]
