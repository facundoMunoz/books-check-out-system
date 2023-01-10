Class {
	#name : #BotonAccion,
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'bloqueAccion'
	],
	#category : #'books-check-out-system'
}

{ #category : #construction }
BotonAccion class >> crear: unLabel color: unColor posicion: unasCoordenadas yFuncion: unBloque [

	| nuevoBoton |
	nuevoBoton := self new.
	nuevoBoton
		iniciar: unLabel
		color: unColor 
		posicion: unasCoordenadas
		yFuncion: unBloque.
	^ nuevoBoton
]

{ #category : #construction }
BotonAccion class >> crearAuxiliar: unLabel color: unColor posicion: unasCoordenadas yFuncion: unBloque [

	| nuevoBoton |
	nuevoBoton := self new.
	nuevoBoton
		iniciarAuxiliar: unLabel
		color: unColor
		posicion: unasCoordenadas
		yFuncion: unBloque.
	^ nuevoBoton
]

{ #category : #initialization }
BotonAccion >> iniciar: unNombre color: unColor posicion: unasCoordenadas yFuncion: unBloque [

	"Iniciamos funciones y variables de la clase SimpleButtonMorph"

	self initialize.

	"Utilizamos nuestro propio label para poder cambiar el estilo"
	self label: ''.
	label := StringMorph new.
	label
		contents: unNombre;
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 15);
		emphasis: TextEmphasis bold emphasisCode.

	"Agregamos el texto y definimos el resto del estilo del botón"
	self
		addMorph: label;
		borderWidth: 0;
		color: unColor;
		extent: 200 @ 50;
		center: unasCoordenadas.

	"Definimos la acción del botón"
	bloqueAccion := unBloque
]

{ #category : #initialization }
BotonAccion >> iniciarAuxiliar: unNombre color: unColor posicion: unasCoordenadas yFuncion: unBloque [

	"Iniciamos funciones y variables de la clase SimpleButtonMorph"

	self initialize.

	"Utilizamos nuestro propio label para poder cambiar el estilo"
	self label: ''.
	label := StringMorph new.
	label
		contents: unNombre;
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 13);
		emphasis: TextEmphasis bold emphasisCode.

	"Agregamos el texto y definimos el resto del estilo del botón"
	self
		addMorph: label;
		borderWidth: 0;
		color: unColor;
		extent: 100 @ 25;
		position: unasCoordenadas.

	"Definimos la acción del botón"
	bloqueAccion := unBloque
]

{ #category : #'event handling' }
BotonAccion >> mouseAction: bloque [
"Definimos la acción del botón"
	bloqueAccion := bloque
]

{ #category : #'event handling' }
BotonAccion >> mouseUp: unEvento [

	super mouseUp: unEvento.
	bloqueAccion value
]
