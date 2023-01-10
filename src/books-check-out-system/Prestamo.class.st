Class {
	#name : #Prestamo,
	#superclass : #Object,
	#instVars : [
		'usuario',
		'colLibros',
		'fechaInicio',
		'fechaDevolucion'
	],
	#category : #'books-check-out-system'
}

{ #category : #aplicacion }
Prestamo >> estaRetrasado: duracionDiasPrestamo [

	"Devuelve true si entre hoy y la fecha de inicio hay más días que el límite"

	^ (Date today - fechaInicio) asDays > duracionDiasPrestamo
]

{ #category : #observadores }
Prestamo >> getUsuario [
	^ usuario
]

{ #category : #initialization }
Prestamo >> iniciar: unUsuario libros: unosLibros [
	usuario := unUsuario .
	colLibros := unosLibros .
	fechaInicio := Date today
]
