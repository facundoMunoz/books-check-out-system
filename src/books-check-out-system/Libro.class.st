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
