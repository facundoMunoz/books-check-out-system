"
TDA que representa una biblioteca

### Variables de instancia
	colLibros:		<OrderedCollection>
	colPrestamosActuales:		<OrderedCollection>
	direccion:		<String>
	duracionDiasPrestamo:		<Integer>
	id:		<Integer>
	nombre:		<String>
	nombreRepresentante:		<String>
	telefono:		<String>
"
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
	#classInstVars : [
		'diasSuspension'
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
Biblioteca class >> getDiasSuspension [

	^ diasSuspension 
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

{ #category : #aplicacion }
Biblioteca >> devolverPrestamo: unUsuario [

	| prestamos exito |
	exito := false.
	prestamos := colPrestamosActuales select: [ :prestamo | 
		             prestamo coincideUsuario: unUsuario ].
	prestamos ifNotEmpty: [ 
		prestamos do: [ :prestamo | 
			| posicion |
			prestamo devolver: duracionDiasPrestamo.
			posicion := colPrestamosActuales indexOf: prestamo.
			colPrestamosActuales removeAt: posicion ].
		exito := true ].
	^ exito
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

{ #category : #aplicacion }
Biblioteca >> getPrestamosUsuario: unUsuario [

	^ colPrestamosActuales select: [ :prestamo | 
		prestamo coincideUsuario: unUsuario ]
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

{ #category : #private }
Biblioteca >> nuevoPrestamo: unPrestamo [

colPrestamosActuales add: unPrestamo 
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

{ #category : #adding }
Biblioteca >> registrarPrestamo: unUsuario libros: unaColLibros [

	| exito |
	exito := false.
	(self tienePrestamoActivo: unUsuario) ifFalse: [ 
		(unUsuario
			 puedeSolicitarPrestamo: unaColLibros
			 diasSuspension: self class getDiasSuspension) ifTrue: [ 
			| colLibrosRegulares colLibrosPlus |
			colLibrosRegulares := unaColLibros reject: [ :libro | 
				                      libro necesitaPlus ].
			colLibrosPlus := unaColLibros select: [ :libro | 
				                 libro necesitaPlus ].
			colLibrosRegulares ifNotEmpty: [ 
				self nuevoPrestamo:
					(Prestamo
						 crear: unUsuario
						 biblioteca: self
						 libros: colLibrosRegulares) ].
			colLibrosPlus ifNotEmpty: [ 
				self nuevoPrestamo:
					(PrestamoPlus crear: unUsuario biblioteca: self libros: colLibrosPlus) ].
			exito := true ] ].
	^ exito
]

{ #category : #aplicacion }
Biblioteca >> tienePrestamoActivo: unUsuario [

	| tiene |
	tiene := false.
	colPrestamosActuales do: [ :prestamo | 
		(prestamo coincideUsuario: unUsuario) ifTrue: [tiene := true]].
	^ tiene
]
