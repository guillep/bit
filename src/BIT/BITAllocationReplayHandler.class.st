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
BITAllocationReplayHandler >> allocationStream [

	^ allocationStream
]

{ #category : 'accessing' }
BITAllocationReplayHandler >> allocationStream: anObject [

	allocationStream := anObject
]

{ #category : 'accessing' }
BITAllocationReplayHandler >> insteadExecutionWithReceiver: anObject [
	<debuggerCompleteToSender>
	"Ignore the allocated object. Replay the old one!"
	^ allocationStream next haltMaybe
]

{ #category : 'accessing' }
BITAllocationReplayHandler >> insteadExecutionWithReceiver: anObject with: argument [
	<debuggerCompleteToSender>
	"Ignore the allocated object. Replay the old one!"
	^ allocationStream next haltMaybe
]

{ #category : 'accessing' }
BITAllocationReplayHandler >> insteadExecutionWithReceiver: anObject with: argument with: argument2 [
	<debuggerCompleteToSender>
	"Ignore the allocated object. Replay the old one!"
	^ allocationStream next haltMaybe
]
