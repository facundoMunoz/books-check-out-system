Class {
	#name : #DropListMorphColored,
	#superclass : #DropListMorph,
	#category : #'books-check-out-system'
}

{ #category : #private }
DropListMorphColored >> layoutInsetToUse [

	"Answer the layout inset that should be used."

	^ 0
]

{ #category : #'instance creation' }
DropListMorphColored >> newContentMorph [

	"Answer a new content morph"

	| pt |
	pt := RubPluggableTextFieldMorph new
		      alwaysAccept: true;
		      acceptOnCR: true;
		      getEnabledSelector: nil;
		      font: self theme textFont;
		      cornerStyle: (self theme textEntryCornerStyleIn: self);
		      hResizing: #spaceFill;
		lock;
		      setBalloonText: nil.
	^ pt
]

{ #category : #initialization }
DropListMorphColored >> setColor: unColor [

	self color: unColor.
	contentMorph color: unColor
]
