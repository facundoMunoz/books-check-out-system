Class {
	#name : #UsuarioPlus,
	#superclass : #Usuario,
	#instVars : [
		'fechaPago',
		'nroTarjeta',
		'codigoSeguridad'
	],
	#category : #'books-check-out-system'
}

{ #category : #construction }
UsuarioPlus class >> crearDni: unDni nombre: unNombre apellido: unApellido contrasenia: unaContrasenia nroTarjeta: unNroTarjeta codSeguridad: unCodSeguridad colBibliotecasFav: unaColFavoritas [

	| usuario |
	usuario := self new.
	usuario
		iniciar: unDni
		nombre: unNombre
		apellido: unApellido
		contrasenia: unaContrasenia
		nroTarjeta: unNroTarjeta
		codSeguridad: unCodSeguridad colBibliotecasFav: unaColFavoritas.
	^ usuario
]

{ #category : #converting }
UsuarioPlus >> asUsuarioRegular [

	| nuevoRegular |
	nuevoRegular := Usuario 
		                crearDni: dni
		                nombre: nombre
		                apellido: apellido
		                contrasenia: contrasenia.
	^ nuevoRegular
]

{ #category : #observadores }
UsuarioPlus >> getTipo [
^ 'Plus'
]

{ #category : #initialization }
UsuarioPlus >> iniciar: unDni nombre: unNombre apellido: unApellido contrasenia: unaContrasenia nroTarjeta: unNroTarjeta codSeguridad: unCodSeguridad colBibliotecasFav: unaColFavoritas [

	dni := unDni.
	nombre := unNombre.
	apellido := unApellido.
	contrasenia := unaContrasenia.
	nroTarjeta := unNroTarjeta.
	codigoSeguridad := unCodSeguridad.
	colBibliotecasFav := unaColFavoritas.
	fechaPago := Date today
]
