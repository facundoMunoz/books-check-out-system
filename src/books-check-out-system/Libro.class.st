"
TDA que representa un libro

### Variables de instancia
	anioEdicion:		<Integer>
	colAutores:		<OrderedCollection>
	disponible:		<Boolean>
	editorial:		<String>
	id:		<Integer>
	nombre:		<String>
	tipo:		<String>

"
Class {
	#name : #Libro,
	#superclass : #Object,
	#instVars : [
		'id',
		'nombre',
		'editorial',
		'anioEdicion',
		'tipo',
		'disponible',
		'colAutores'
	],
	#category : #'books-check-out-system'
}

{ #category : #construction }
Libro class >> crearId: unaId nombre: unNombre editorial: unaEditorial anioEdicion: unAnio tipo: unTipo colAutores: unosAutores [
| libro |
libro := self new.
libro iniciarId: unaId nombre: unNombre editorial: unaEditorial anioEdicion: unAnio tipo: unTipo colAutores: unosAutores.
^ libro
]

{ #category : #aplicacion }
Libro >> clonar [

	^ self class
		  crearId: id
		  nombre: nombre
		  editorial: editorial
		  anioEdicion: anioEdicion
		  tipo: tipo
		  colAutores: colAutores
]

{ #category : #aplicacion }
Libro >> correspondeId: unaId [

	"Verifica si la id corresponde con el libro"

	^ unaId = id
]

{ #category : #observadores }
Libro >> getAnioEdicion [
^ anioEdicion 
]

{ #category : #observadores }
Libro >> getDisponible [
^ disponible
]

{ #category : #observadores }
Libro >> getDisponibleString [
| disp |
disp:= 'No'.
disponible ifTrue: [ disp := 'Sí' ].
^ disp
]

{ #category : #observadores }
Libro >> getEditorial [
^ editorial
]

{ #category : #observadores }
Libro >> getId [ 
^id 
]

{ #category : #observadores }
Libro >> getNombre [ 
^ nombre
]

{ #category : #observadores }
Libro >> getTipo [ 
^ tipo
]

{ #category : #initialization }
Libro >> iniciarId: unaId nombre: unNombre editorial: unaEditorial anioEdicion: unAnio tipo: unTipo colAutores: unosAutores [

	id := unaId.
	nombre := unNombre.
	editorial := unaEditorial.
	anioEdicion := unAnio.
	tipo := unTipo.
	colAutores := unosAutores.
	"Al momento de cargarlo suponemos que está disponible"
	disponible := true
]

{ #category : #observadores }
Libro >> necesitaPlus [

^ false
]

{ #category : #initialization }
Libro >> setDisponible: aBoolean [
disponible := aBoolean 
]
