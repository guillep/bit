Class {
	#name : 'BITAllocationTrackerHandler',
	#superclass : 'MpHandler',
	#instVars : [
		'allocations'
	],
	#category : 'BIT',
	#package : 'BIT'
}

{ #category : 'evaluating' }
BITAllocationTrackerHandler >> afterExecutionWithReceiver: anObject returnValue: returnValue [

	"We captured a newly built object!
	Store it."

	allocations addLast: returnValue.
	^ returnValue
]

{ #category : 'evaluating' }
BITAllocationTrackerHandler >> afterExecutionWithReceiver: anObject with: arg2 returnValue: returnValue [

	"We captured a newly built object!
	Store it."

	allocations addLast: returnValue.
	^ returnValue
]

{ #category : 'evaluating' }
BITAllocationTrackerHandler >> afterExecutionWithReceiver: anObject with: arg1 with: arg2 returnValue: returnValue [

	"We captured a newly built object!
	Store it."

	allocations addLast: returnValue.
	^ returnValue
]

{ #category : 'accessing' }
BITAllocationTrackerHandler >> allocations [

	^ allocations
]

{ #category : 'accessing' }
BITAllocationTrackerHandler >> allocations: anObject [

	allocations := anObject
]

{ #category : 'initialization' }
BITAllocationTrackerHandler >> initialize [

	super initialize.
	allocations := OrderedCollection new
]
