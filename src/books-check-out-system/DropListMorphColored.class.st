Class {
	#name : #DropListMorphColored,
	#superclass : #DropListMorph,
	#instVars : [
		'backgroundColor'
	],
	#category : #'books-check-out-system'
}

{ #category : #private }
DropListMorphColored >> layoutInsetToUse [

	"Answer the layout inset that should be used."

	^ 0
]

{ #category : #private }
DropListMorphColored >> listMorphClass [

	"Answer the class for a new list morph"

	^ PluggableListMorphColored 
]

{ #category : #'instance creation' }
DropListMorphColored >> newContentMorph [

	"Answer a new content morph"

	| pt |
	pt := RubPluggableTextFieldMorph new
		      alwaysAccept: true;
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

	backgroundColor := unColor.
	contentMorph color: unColor.
	contentMorph textColor: Color white
]

{ #category : #updating }
DropListMorphColored >> updateContentColor: paneColor [

	"Change the content text color."

	self contentMorph textColor: Color white
]

{ #category : #private }
DropListMorphColored >> updateContentMorphWith: aString [

	self contentMorph setTextWith: aString asString.
	self contentMorph textColor: Color white
]
