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

{ #category : #adding }
Biblioteca >> agregarLibro: unLibro [

	"Verifica que no repita id, devuelve false si es el caso"

	| agregado |
	agregado := false.
	colLibros 
		detect: [ :libro | 
		unLibro correspondeId: libro getId ]
		ifNone: [ 
			agregado := true.
			colLibros add: unLibro ].
	^ agregado
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

{ #category : #observadores }
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

{ #category : #removing }
Biblioteca >> quitarLibro: unLibro [
| eliminado posicion |
eliminado := false.
unLibro getDisponible ifTrue: [ "Si no está en un prestamo y pertenece a la colección lo borramos"
	posicion :=colLibros indexOf: unLibro.
	posicion = 0 ifFalse: [ colLibros removeAt: posicion. eliminado := true ] ].
^ eliminado
]
