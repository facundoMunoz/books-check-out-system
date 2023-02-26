"
PluggableListMorphColored que redefine el Morph que utiliza para la lista a una que permite cambiar el color del contenido.
"
Class {
	#name : #PluggableListMorphColored,
	#superclass : #PluggableListMorph,
	#category : #'books-check-out-system'
}

{ #category : #private }
PluggableListMorphColored >> listMorphClass [
^ LazyListMorphColored 
]
