"
DropListMorph que permite cambiar el color del contenido y define una lista con color predeterminado
"
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
		      setBalloonText: nil;
		      lock.
	^ pt
]

{ #category : #initialization }
DropListMorphColored >> setColor: unColor [

	contentMorph color: unColor.
	contentMorph textColor: Color white.
	self updateContents
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
