"
TDA que representa un usuario plus

###Variables de instancia
	codigoSeguridad:		<Integer>
	fechaPago:		<Date>
	nroTarjeta:		<Integer>
"
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
		nuevoRegular 
		                setColBibliotecasFav: self getBibliotecasFavoritas.
	^ nuevoRegular
]

{ #category : #private }
UsuarioPlus >> getCodSeguridad [
^ codigoSeguridad 
]

{ #category : #private }
UsuarioPlus >> getFechaPago [
^ fechaPago
]

{ #category : #private }
UsuarioPlus >> getNroTarjeta [
^ nroTarjeta 
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

{ #category : #private }
UsuarioPlus >> puedeSolicitarLibros: unaColLibros [

	^ ((Date today - fechaPago) asDays < 30)
]
