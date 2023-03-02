"
TDA que representa un usuario regular

###Variables de instancia
dni:  <Integer>
nombre:  <String>
apellido:  <String>
contrasenia:  <String>
colBibliotecasFav:   <OrderedCollection>
"
Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'dni',
		'nombre',
		'apellido',
		'contrasenia',
		'fechaSuspension',
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

{ #category : #private }
Usuario >> puedeSolicitarLibros: unaColLibros [

	| puede |
	puede := true.
	unaColLibros do: [ :libro | 
		libro necesitaPlus ifTrue: [ puede := false ] ].
	^ puede
]

{ #category : #aplicacion }
Usuario >> puedeSolicitarPrestamo: unaColLibros diasSuspension: diasSuspension [

	| puede |
	puede := true.
	unaColLibros do: [ :libro | 
		libro getDisponible ifFalse: [ puede := false ] ].
	puede & (self puedeSolicitarLibros: unaColLibros) ifTrue: [ 
		fechaSuspension isNotNil ifTrue: [ "Verifica si se superaron los días mínimos desde la suspensión" 
			puede := (Date today - fechaSuspension) asDays > diasSuspension ] ] ifFalse: [puede := false].
	^ puede
]

{ #category : #modificadores }
Usuario >> setColBibliotecasFav: unaColFav [
colBibliotecasFav := unaColFav 
]

{ #category : #aplicacion }
Usuario >> suspender [
fechaSuspension := Date today
]
