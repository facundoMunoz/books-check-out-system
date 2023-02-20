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
Usuario >> agregarBibliotecaFav: unaBiblioteca [
	colBibliotecasFav add: unaBiblioteca
]

{ #category : #converting }
Usuario >> asUsuarioPlusTarjeta: nroTarjeta codigoSeguridad: unCodSeguridad [

	| nuevoPlus |
	nuevoPlus := UsuarioPlus
		             crearDni: dni
		             nombre: nombre
		             apellido: apellido
		             contrasenia: contrasenia
		             nroTarjeta: nroTarjeta
		             codSeguridad: unCodSeguridad
		             colBibliotecasFav: colBibliotecasFav.
		^nuevoPlus 
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
Usuario >> getContrasenia [
^ contrasenia 
]

{ #category : #observadores }
Usuario >> getDni [

^ dni
]

{ #category : #observadores }
Usuario >> getNombre [
^ nombre
]

{ #category : #observadores }
Usuario >> getTipo [
^ 'Regular'
]

{ #category : #initialization }
Usuario >> iniciar: unDni nombre: unNombre apellido: unApellido contrasenia: unaContrasenia [

	dni := unDni.
	nombre := unNombre.
	apellido := unApellido.
	contrasenia := unaContrasenia.
	colBibliotecasFav := OrderedCollection new
]

{ #category : #modificadores }
Usuario >> setColBibliotecasFav: unaColFav [
colBibliotecasFav := unaColFav 
]
