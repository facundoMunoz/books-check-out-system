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
