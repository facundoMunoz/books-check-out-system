"
TDA que representa un audiolibro
"
Class {
	#name : #Audiolibro,
	#superclass : #Libro,
	#category : #'books-check-out-system'
}

{ #category : #observadores }
Audiolibro >> getNombre [ 
 ^ nombre , ' (+)'
]

{ #category : #observadores }
Audiolibro >> necesitaPlus [
^ true
]
