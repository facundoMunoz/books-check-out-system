"
Clase encargada de administrar la red de bibliotecas, usuarios y préstamos

###Variables de instancia
	colAutores:		<OrderedCollection>
	colBibliotecas:		<OrderedCollection>
	colUsuarios:		<OrderedCollection>
"
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

	"Bibliotecas"

	self
		agregarBiblioteca: (Biblioteca
				 crearId: 1
				 direccion: 'Av. Sta. Fe 1860'
				 nombre: 'El Ateneo'
				 telefono: '011 5420-2938'
				 nombreRepresentante: 'Carlos'
				 duracionDiasPrestamo: 31);
		agregarBiblioteca: (Biblioteca
				 crearId: 2
				 direccion: 'Av. Sta. Fe 1860'
				 nombre: 'Tres Tristes Tigres'
				 telefono: '011 5420-2938'
				 nombreRepresentante: 'Carlos'
				 duracionDiasPrestamo: 31);
		agregarBiblioteca: (Biblioteca
				 crearId: 3
				 direccion: 'Av. Sta. Fe 1860'
				 nombre: 'El fin del mundo'
				 telefono: '011 5420-2938'
				 nombreRepresentante: 'Carlos'
				 duracionDiasPrestamo: 31);
		agregarBiblioteca: (Biblioteca
				 crearId: 4
				 direccion: 'Av. Sta. Fe 1860'
				 nombre: 'Nacional'
				 telefono: '011 5420-2938'
				 nombreRepresentante: 'Carlos'
				 duracionDiasPrestamo: 31);
		agregarBiblioteca: (Biblioteca
				 crearId: 5
				 direccion: 'Av. Sta. Fe 1860'
				 nombre: 'Sombrerero Loco'
				 telefono: '011 5420-2938'
				 nombreRepresentante: 'Carlos'
				 duracionDiasPrestamo: 31);
		agregarBiblioteca: (Biblioteca
				 crearId: 6
				 direccion: 'Av. Sta. Fe 1860'
				 nombre: 'Colección de Dragones'
				 telefono: '011 5420-2938'
				 nombreRepresentante: 'Carlos'
				 duracionDiasPrestamo: 31).
	"Usuarios"
	self
		agregarUsuario: (Usuario
				 crearDni: 43156688
				 nombre: 'Facundo'
				 apellido: 'Muñoz'
				 contrasenia: 'contrasenia123');
		agregarUsuario: (Usuario
				 crearDni: 44000000
				 nombre: 'Cristopher'
				 apellido: 'Ovaillos'
				 contrasenia: 'contrasenia123');
		agregarUsuario: (Usuario
				 crearDni: 44000001
				 nombre: 'Celina'
				 apellido: 'Gramajo'
				 contrasenia: 'contrasenia123')
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

{ #category : #observadores }
Sistema >> getBibliotecas [
^ colBibliotecas
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

{ #category : #observadores }
Sistema >> getUsuarios [
^ colUsuarios
]

{ #category : #initialization }
Sistema >> initialize [

super initialize.
	"Creamos las colecciones de datos"
	colBibliotecas := OrderedCollection new.
	colUsuarios := OrderedCollection new.
	colAutores := OrderedCollection new
]

{ #category : #aplicacion }
Sistema >> quitarUsuario: unUsuario [

	"Buscamos dni, elimina si es el caso"

	| quitado posicion |
	quitado := false.
	 posicion := colUsuarios
		indexOf: [ :usuario | unUsuario correspondeDni: usuario getDni ].
		(posicion = 0) ifFalse: [ 
			colUsuarios removeAt: posicion.
			quitado := true ].
	^ quitado
]
