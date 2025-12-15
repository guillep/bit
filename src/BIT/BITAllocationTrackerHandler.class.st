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
BITAllocationTrackerHandler >> afterExecutionWithReceiver: anObject arguments: anArrayOfObjects returnValue: returnValue [

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
