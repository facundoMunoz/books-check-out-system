Class {
	#name : #Sistema,
	#superclass : #Object,
	#instVars : [
		'colBibliotecas',
		'colUsuarios',
		'colAutores'
	],
	#category : #'books-check-out-system'
}

{ #category : #aplicacion }
Sistema >> agregarBiblioteca: unaBiblioteca [

	"Verifica que no repita id, devuelve false si es el caso"

	| agregado |
	agregado := false.
	colBibliotecas detect: [ :biblioteca | 
		                 unaBiblioteca correspondeId: biblioteca getId ] ifNone: [ 
		agregado := true.
		colBibliotecas add: unaBiblioteca ].
	^ agregado
]

{ #category : #aplicacion }
Sistema >> agregarUsuario: unUsuario [

	"Verifica que no repita dni, devuelve false si es el caso"

	| agregado |
	agregado := false.
	colUsuarios
		detect: [ :usuario | 
		unUsuario correspondeDni: usuario getDni ]
		ifNone: [ 
			agregado := true.
			colUsuarios add: unUsuario ].
	^ agregado
]

{ #category : #testing }
Sistema >> cargaInicialPrueba [

	self agregarBiblioteca: (Biblioteca
			 crearId: 1
			 direccion: 'Av. Sta. Fe 1860'
			 nombre: 'El Ateneo'
			 telefono: '011 5420-2938'
			 nombreRepresentante: 'Carlos'
			 duracionDiasPrestamo: 31).
			self agregarUsuario: (Usuario crearDni: 43156688 nombre: 'Facundo' apellido: 'Muñoz'  contrasenia: 'caracoles13' )
]

{ #category : #aplicacion }
Sistema >> getBiblioteca: unaId [

	"Devuelve la biblioteca que corresponde a la id o nil si no la encuentra"

	| biblioteca posicion |
	biblioteca := nil.
	posicion := colBibliotecas
		            findFirst: [ :bibliotecaActual | 
		            bibliotecaActual correspondeId: unaId ].
		           (posicion > 0) ifTrue: [ biblioteca := colBibliotecas at: posicion ].
	^ biblioteca
]

{ #category : #aplicacion }
Sistema >> getUsuario: unDni [

	"Devuelve la biblioteca que corresponde a la id o nil si no la encuentra"

	| usuario posicion |
	usuario := nil.
	posicion := colUsuarios findFirst: [ :usuarioActual | 
		            usuarioActual correspondeDni: unDni ].
	posicion > 0 ifTrue: [ usuario := colUsuarios at: posicion ].
	^ usuario
]

{ #category : #initialization }
Sistema >> initialize [

super initialize.
	"Creamos las colecciones de datos"
	colBibliotecas := OrderedCollection new.
	colUsuarios := OrderedCollection new.
	colAutores := OrderedCollection new
]