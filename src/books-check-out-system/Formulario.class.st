"
Morph de área de texto que evita que el cursor quede como 'text pointer' luego de dar click en el área.
"
Class {
	#name : #Formulario,
	#superclass : #RubTextFieldMorph,
	#category : #'books-check-out-system'
}

{ #category : #'event handling' }
Formulario >> handlesMouseDown: event [

	^ true
]

{ #category : #'event handling' }
Formulario >> mouseDown: evt [
    evt hand waitForClicksOrDrag: self event: evt
]
