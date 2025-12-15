Class {
	#name : 'BITSession',
	#superclass : 'Object',
	#instVars : [
		'recording',
		'ps',
		'endOfRecord',
		'actionBlock'
	],
	#category : 'BIT',
	#package : 'BIT'
}

{ #category : 'actions api' }
BITSession >> instrumentAllocationsWith: instrumentationHandler [

	| p1 p2 p3 p4 p5 |
	p1 := MpMethodProxy onMethod: Behavior >> #basicNew handler: instrumentationHandler.
	p2 := MpMethodProxy onMethod: Behavior >> #basicNew: handler: instrumentationHandler.
	p3 := MpMethodProxy onMethod: ArrayedCollection class >> #new: handler: instrumentationHandler.
	p4 := MpMethodProxy onMethod: Interval class >> #new handler: instrumentationHandler.
	p5 := MpMethodProxy onMethod: CompiledCode class >> #basicNew:header: handler: instrumentationHandler.
	ps := {
		      p1.
		      p2.
		      p3.
		      p4.
		      p5 }.
	ps do: [ :p | p install ].
	^ MpMethodProxy enableInstrumentation
]

{ #category : 'as yet unclassified' }
BITSession >> numberOfEvents [

	^ recording allocations size
]

{ #category : 'actions api' }
BITSession >> prepareRecording [

	recording allocations do: [ :r |
			r class isPointers
				ifTrue: [
						1 to: r class instSize do: [ :i | r instVarAt: i put: nil ].
						1 to: r basicSize do: [ :i | r basicAt: i put: nil ] ]
				ifFalse: [
						r isCompiledMethod
							ifTrue: [
								1 to: r numLiterals do: [ :i |
										"Do not override the header..."
										r literalAt: i put: nil ].
								r initialPC to: r basicSize
									do: [ :i | r basicAt: i put: 0 ] ]
							ifFalse: [ 
								1 to: r basicSize
									do: [ :i | r basicAt: i put: 0 ] ] ] ]
]

{ #category : 'actions api' }
BITSession >> record: aBlock [

	| result |
	actionBlock ifNotNil: [ self error: 'I already have a recording!' ].
	actionBlock := aBlock.

	[self startRecording.
	result := aBlock ensure: [ self stopRecording ]]
		forkAt: Processor highIOPriority.
		
	self waitEndOfRecord.
	^ result
]

{ #category : 'accessing' }
BITSession >> recording [
	^ recording
]

{ #category : 'actions api' }
BITSession >> replay [
	
	"Stop at the last event"
	^ self replayUpTo: self numberOfEvents
]

{ #category : 'actions api' }
BITSession >> replayUpTo: n [
	
	| result |
	[self startReplayingUpTo: n.
	result := actionBlock ensure: [ self stopRecording ]]
		forkAt: Processor highIOPriority.
		
	self waitEndOfRecord.
	^ result
]

{ #category : 'actions api' }
BITSession >> startRecording [

	| instrumentationHandler |
	endOfRecord := Semaphore new.
	recording := instrumentationHandler := BITAllocationTrackerHandler new.
	self instrumentAllocationsWith: instrumentationHandler
]

{ #category : 'actions api' }
BITSession >> startReplaying [

	"Just don't stop"
	^ self startReplayingUpTo: recording allocations size + 1
]

{ #category : 'actions api' }
BITSession >> startReplayingUpTo: n [

	| copy |
	recording ifNil: [ self error: 'No recording available!' ].
	endOfRecord := Semaphore new.

	copy := recording allocations copy.
	copy at: n put: (BITHalter new
			 realObject: (copy at: n);
			 session: self;
			 yourself).

	self prepareRecording.
	self instrumentAllocationsWith: (BITAllocationReplayHandler newOn: copy)
]

{ #category : 'actions api' }
BITSession >> stopRecording [

	MpMethodProxy disableInstrumentation.
	ps do: [ :p | p uninstall ].

	endOfRecord signal.
]

{ #category : 'actions api' }
BITSession >> waitEndOfRecord [

	endOfRecord wait.
]
