"
LazyListMorph con color predefinido
"
Class {
	#name : #LazyListMorphColored,
	#superclass : #LazyListMorph,
	#instVars : [
		'listColor'
	],
	#category : #'books-check-out-system'
}

{ #category : #'row management' }
LazyListMorphColored >> colorForRow: row [

	"Answer the color for the row text."

	^ Color white
]

{ #category : #drawing }
LazyListMorphColored >> drawOn: aCanvas [

	listItems isEmpty ifTrue: [ ^ self ].

	aCanvas fillRectangle: aCanvas clipRect color: listColor.

	"self drawSelectionOn: aCanvas."
	(self topVisibleRowForCanvas: aCanvas) to:
		(self bottomVisibleRowForCanvas: aCanvas) do: [ :row | 
		(listSource itemSelectedAmongMultiple: row)
			ifTrue: [ self drawBackgroundForSelectedRow: row on: aCanvas ]
			ifFalse: [ 
				listSource searchedElement = row
					ifTrue: [ self drawBackgroundForSearchedRow: row on: aCanvas ]
					ifFalse: [ 
						(listSource backgroundColorFor: row) ifNotNil: [ :col | 
							self drawBackgroundForRow: row on: aCanvas color: col ] ] ].

		selectedRow = row ifTrue: [ self drawSelectionOn: aCanvas ].
		(listSource separatorAfterARow: row) ifTrue: [ 
			self drawSeparatorAfter: row on: aCanvas ].
		self display: (self item: row) atRow: row on: aCanvas ].

	listSource potentialDropRow > 0 ifTrue: [ 
		self
			highlightPotentialDropRow: listSource potentialDropRow
			on: aCanvas ]
]

{ #category : #initialization }
LazyListMorphColored >> initialize [

	super initialize.
	listColor := Color r: 60 / 255 g: 60 / 255 b: 60 / 255
]
