Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'dni',
		'nombre',
		'apellido',
		'contrasenia',
		'colBibliotecasFav'
	],
	#category : #'books-check-out-system'
}

{ #category : #construction }
Usuario class >> crearDni: unDni nombre: unNombre apellido: unApellido contrasenia: unaContrasenia [

	| usuario |
	usuario := self new.
	usuario
		iniciar: unDni
		nombre: unNombre
		apellido: unApellido
		contrasenia: unaContrasenia.
	^ usuario
]

{ #category : #aplicacion }
Usuario >> correspondeDni: unDni [

	"Verifica si el dni corresponde con el usuario"

	^ unDni = dni
]

{ #category : #observadores }
Usuario >> getApellido [
^ apellido
]

{ #category : #observadores }
Usuario >> getBibliotecasFavoritas [
	^ colBibliotecasFav
]

{ #category : #observadores }
Usuario >> getDni [

^ dni
]

{ #category : #observadores }
Usuario >> getNombre [
^ nombre
]

{ #category : #initialization }
Usuario >> iniciar: unDni nombre: unNombre apellido: unApellido contrasenia: unaContrasenia [

	dni := unDni.
	nombre := unNombre.
	apellido := unApellido.
	contrasenia := unaContrasenia.
	colBibliotecasFav := OrderedCollection new
]
