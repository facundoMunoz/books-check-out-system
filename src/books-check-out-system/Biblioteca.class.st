Class {
	#name : #Biblioteca,
	#superclass : #Object,
	#instVars : [
		'id',
		'direccion',
		'nombre',
		'telefono',
		'nombreRepresentante',
		'duracionDiasPrestamo',
		'colLibros',
		'colPrestamosActuales'
	],
	#category : #'books-check-out-system'
}

{ #category : #construction }
Biblioteca class >> crearId: unaId direccion: unaDir nombre: unNom telefono: unTel nombreRepresentante: unNomRep duracionDiasPrestamo: unosDias [

	| bibliotecaNueva |
	bibliotecaNueva := self new.
	bibliotecaNueva
		iniciarId: unaId
		direccion: unaDir
		nombre: unNom
		telefono: unTel
		nombreRepresentante: unNomRep
		duracionDiasPrestamo: unosDias.
	^ bibliotecaNueva
]

{ #category : #aplicacion }
Biblioteca >> correspondeId: unaId [
	"Verifica si la id corresponde con la biblioteca"
	^ (unaId = id)
]

{ #category : #observadores }
Biblioteca >> getDireccion [
^ direccion 
]

{ #category : #observadores }
Biblioteca >> getDuracionDiasPrestamo [
^ duracionDiasPrestamo 
]

{ #category : #observadores }
Biblioteca >> getId [
	^ id
]

{ #category : #aplicacion }
Biblioteca >> getLibros [
^ colLibros
]

{ #category : #observadores }
Biblioteca >> getNombre [

^ nombre
]

{ #category : #observadores }
Biblioteca >> getNombreRepresentante [

^ nombreRepresentante 
]

{ #category : #observadores }
Biblioteca >> getPrestamos [
^ colPrestamosActuales
]

{ #category : #observadores }
Biblioteca >> getTelefono [
^ telefono 
]

{ #category : #initialization }
Biblioteca >> iniciarId: unaId direccion: unaDir nombre: unNom telefono: unTel nombreRepresentante: unNomRep duracionDiasPrestamo: unosDias [

	id := unaId.
	direccion := unaDir.
	nombre := unNom.
	telefono := unTel.
	nombreRepresentante := unNomRep.
	duracionDiasPrestamo := unosDias.
	colLibros := OrderedCollection new.
	colPrestamosActuales := OrderedCollection new
]
