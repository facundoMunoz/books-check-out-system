"
TDA que representa un préstamo de libros regulares

###Variables de instancia
	colLibros:		<OrderedCollection>
	fechaDevolucion:		<Date>
	fechaInicio:		<Date>
	usuario:		<Usuario>
"
Class {
	#name : #Prestamo,
	#superclass : #Object,
	#instVars : [
		'usuario',
		'biblioteca',
		'colLibros',
		'fechaInicio'
	],
	#category : #'books-check-out-system'
}

{ #category : #construction }
Prestamo class >> crear: unUsuario biblioteca: unaBiblioteca libros: unosLibros [

	| prestamoNuevo |
	prestamoNuevo := self new.
	prestamoNuevo iniciar: unUsuario biblioteca: unaBiblioteca libros: unosLibros.
	^ prestamoNuevo
]

{ #category : #aplicacion }
Prestamo >> coincideUsuario: unUsuario [

	^ unUsuario correspondeDni: usuario getDni
]

{ #category : #aplicacion }
Prestamo >> devolver: duracionDiasPrestamo [

	(self estaRetrasado: duracionDiasPrestamo) ifTrue: [ usuario suspender ].
	colLibros do: [ :libro | libro setDisponible: true ]
]

{ #category : #aplicacion }
Prestamo >> estaRetrasado: duracionDiasPrestamo [

	"Devuelve true si entre hoy y la fecha de inicio hay más días que el límite"

	^ (Date today - fechaInicio) asDays > duracionDiasPrestamo
]

{ #category : #observadores }
Prestamo >> getBiblioteca [
^ biblioteca 
]

{ #category : #observadores }
Prestamo >> getFechaInicio [
^ fechaInicio 
]

{ #category : #observadores }
Prestamo >> getLibros [ 
^ colLibros 
]

{ #category : #observadores }
Prestamo >> getUsuario [
	^ usuario
]

{ #category : #initialization }
Prestamo >> iniciar: unUsuario biblioteca: unaBiblioteca libros: unosLibros [

	usuario := unUsuario.
	biblioteca := unaBiblioteca .
	colLibros := unosLibros.
	fechaInicio := Date today
]
