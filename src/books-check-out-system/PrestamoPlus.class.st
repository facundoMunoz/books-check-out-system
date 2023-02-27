"
TDA que representa un préstamo cuyos libros requieren 'Plus', que son prestados por la mitad del tiempo de uno regular
"
Class {
	#name : #PrestamoPlus,
	#superclass : #Prestamo,
	#category : #'books-check-out-system'
}

{ #category : #aplicacion }
PrestamoPlus >> estaRetrasado: duracionDiasPrestamo [

	"Los audiolibros se prestan la mitad del tiempo"

	^ (Date today - fechaInicio) asDays > (duracionDiasPrestamo / 2)
]
