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
		detect: [ :usuario | unUsuario correspondeDni: usuario getDni ]
		ifNone: [ 
			agregado := true.
			colUsuarios add: unUsuario ].
	^ agregado
]

{ #category : #testing }
Sistema >> cargaInicialPrueba [

	| colLibrosNuevos |
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
	"Libros"
	colLibrosNuevos := OrderedCollection new.
	colLibrosNuevos
		add: (Libro
				 crearId: 1
				 nombre: 'El principito'
				 editorial: 'Salamandra'
				 anioEdicion: 2023
				 tipo: 'Digital'
				 colAutores: 'Antoine de Saint-Exupéry');
		add: (Libro
				 crearId: 2
				 nombre: 'Coraline'
				 editorial: 'Salamandra'
				 anioEdicion: 2023
				 tipo: 'Físico'
				 colAutores: 'Neil Gaiman');
		add: (Libro
				 crearId: 3
				 nombre: 'Percy Jackson I'
				 editorial: 'Salamandra'
				 anioEdicion: 2023
				 tipo: 'Físico'
				 colAutores: 'Rick Riordan');
		add: (Libro
				 crearId: 4
				 nombre: 'Percy Jackson II'
				 editorial: 'Salamandra'
				 anioEdicion: 2023
				 tipo: 'Físico'
				 colAutores: 'Rick Riordan');
		add: (Libro
				 crearId: 5
				 nombre: 'Percy Jackson III'
				 editorial: 'Salamandra'
				 anioEdicion: 2023
				 tipo: 'Físico'
				 colAutores: 'Rick Riordan');
		add: (Audiolibro
				 crearId: 6
				 nombre: 'El Nombre de la Rosa'
				 editorial: 'Roboto'
				 anioEdicion: 2023
				 tipo: 'Audiolibro'
				 colAutores: 'Umberto Eco').
	colBibliotecas do: [ :biblioteca | 
		colLibrosNuevos do: [ :libro | "Todas las bibliotecas tienen los mismos libros de ejemplo clonados" 
			biblioteca agregarLibro: libro clonar ] ].
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
				 contrasenia: 'contrasenia123');
		agregarUsuario: (Usuario
				 crearDni: 44000002
				 nombre: 'Jesús'
				 apellido: 'Castillo'
				 contrasenia: 'contrasenia123');
		agregarUsuario: (Usuario
				 crearDni: 44000003
				 nombre: 'Silvia'
				 apellido: 'Amaro'
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
Sistema >> getPrestamosUsuario: unUsuario [

	| prestamos |
	prestamos := OrderedCollection new.
	colBibliotecas do: [ :bibliteca | 
		(bibliteca getPrestamosUsuario: unUsuario) do: [ :prestamo | 
			prestamos add: prestamo ] ].
	^ prestamos
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
	posicion := colUsuarios indexOf: unUsuario.
	posicion = 0 ifFalse: [ 
		colUsuarios removeAt: posicion.
		quitado := true ].
	^ quitado
]
