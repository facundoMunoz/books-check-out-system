"
Morph encargado de administrar toda la parte visual del sistema de bibliotecas, siendo ésta la clase que se llama para iniciarlo.

##Ejemplo de uso:
```
| sistemaBiblioteca |
sistemaBiblioteca := SistemaVisual new.
sistemaVisual openInWorld
```
"
Class {
	#name : #SistemaVisual,
	#superclass : #BorderedMorph,
	#instVars : [
		'sistema',
		'colorPrincipal'
	],
	#category : #'books-check-out-system'
}

{ #category : #aplicacion }
SistemaVisual >> crearFormulario: unLabel posicion: unaPosicion [

	"Retorna un formulario de formato genérico dibujando el label"

	| formulario label |
	formulario := Formulario new
		              textFont:
			              (LogicalFont
				               familyName: 'Source Sans Pro'
				               pointSize: 14);
		              backgroundColor: colorPrincipal;
		              extent: 250 @ 0;
		              center: unaPosicion.
	formulario handlesMouseDown: [  ].
	"Agregamos el label"
	label := StringMorph new.
	label
		contents: unLabel;
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 13);
		emphasis: TextEmphasis bold emphasisCode;
		color: colorPrincipal;
		position: formulario topLeft - label bottomLeft.
	self addMorph: label.
	"Retornamos el formulario para acceder al contenido luego"
	^ formulario
]

{ #category : #aplicacion }
SistemaVisual >> crearLista: unaLista bloqueClave: unBloqueClave bloqueAccion: unBloqueAccion [

	| tamanioLista scroll scrollContents elementoActual point |
	"Obtenemos el tamaño"
	tamanioLista := unaLista size.
	"Creamos el panel de scroll"
	scroll := GeneralScrollPaneMorph new.
	scroll
		borderWidth: 1;
		borderColor: colorPrincipal;
		color: Color transparent;
		extent: 598 @ 400;
		center: self center + (0 @ 50).
	self addMorph: scroll.
	"Creamos el contenido del panel"
	scrollContents := BorderedMorph new.
	scrollContents
		borderWidth: 0;
		color: Color transparent;
		extent: 500 @ (tamanioLista * 100 + 50).
	"Hacemos que el scroll siga al contenido"
	scroll scroller addMorph: scrollContents.
	scroll scrollTarget: scrollContents.
	"Listamos los elementos dentro del scroll"
	1 to: tamanioLista do: [ :posVertical | 
		elementoActual := unaLista at: posVertical.
		point := scrollContents center x + 50 @ (posVertical * 100 - 50).
		scrollContents addMorph: (BotonAccion
				 crear: (unBloqueClave value: elementoActual)
				 color: colorPrincipal
				 posicion: point
				 yFuncion: [ unBloqueAccion value: elementoActual ]) ]
]

{ #category : #aplicacion }
SistemaVisual >> crearSelector: unLabel lista: listaOpciones posicion: unaPosicion [

	| selector fuente label |
	fuente := LogicalFont familyName: 'Source Sans Pro' pointSize: 13.
	selector := DropListMorph
		            on: listaOpciones
		            list: #value
		            selected: nil
		            changeSelected: nil.
	selector
		extent: 250 @ 28;
		selectionColor: colorPrincipal;
		font: fuente;
		listFont: fuente;
		center: unaPosicion.
	"Agregamos el label"
	label := StringMorph new.
	label
		contents: unLabel;
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 13);
		emphasis: TextEmphasis bold emphasisCode;
		color: colorPrincipal;
		position: selector topLeft - label bottomLeft.
	self addMorph: label.
	^ selector
]

{ #category : #aplicacion }
SistemaVisual >> crearTexto: unTexto posicion: unaPosicion [

"Dibuja un texto de formato genérico ingresado"
	| texto |
	texto := StringMorph new.
	texto
		contents: unTexto;
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 14);
		emphasis: TextEmphasis bold emphasisCode;
		color: colorPrincipal;
		center: unaPosicion.
	self addMorph: texto
]

{ #category : #aplicacion }
SistemaVisual >> crearTitulo: unContenido [

"Dibuja un título de formato genérico ingresado"
	| titulo |
	titulo := StringMorph new.
	titulo
		contents: unContenido;
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 18);
		emphasis: TextEmphasis bold emphasisCode;
		color: colorPrincipal;
		center: self topCenter + (0 @ 75).
	self addMorph: titulo
]

{ #category : #initialization }
SistemaVisual >> initialize [

	"Heredamos funciones de BorderedMorph"

	super initialize.
	"Creamos el sistema y cargamos datos de prueba"
	sistema := Sistema new.
	sistema cargaInicialPrueba.
	"Estilo de la ventana"
	colorPrincipal := Color r: 71 / 255 g: 90 / 255 b: 105 / 255.
	self borderColor: colorPrincipal.
	self color: Color white.
	self bounds: (self position extent: 600 @ 600).
	"Comenzamos en el menú principal"
	self menuPrincipal
]

{ #category : #aplicacion }
SistemaVisual >> menuAgregarBiblioteca [

	| formId formNombre formDireccion formTelefono formRepresentante formDiasPrestamo |
	self nuevaVentana: [ self menuBibliotecas ] nivel: 3.
	"Título"
	self crearTitulo: 'Añadir biblioteca'.
	"Formulario id"
	formId := self
		          crearFormulario: 'ID'
		          posicion: self center - (-150 @ 75).
	self addMorph: formId.
	"Formulario nombre"
	formNombre := self
		              crearFormulario: 'Nombre'
		              posicion: self center - (150 @ 75).
	self addMorph: formNombre.
	"Formulario dirección"
	formDireccion := self
		                 crearFormulario: 'Dirección'
		                 posicion: self center + (-150 @ 25).
	self addMorph: formDireccion.
	"Formulario telefono"
	formTelefono := self
		                crearFormulario: 'Teléfono'
		                posicion: self center + (150 @ 25).
	self addMorph: formTelefono.
	"Formulario nombre representante"
	formRepresentante := self
		                     crearFormulario: 'Nombre representante'
		                     posicion: self center + (-150 @ 125).
	self addMorph: formRepresentante.
	"Formulario días préstamo"
	formDiasPrestamo := self
		                    crearFormulario: 'Días por préstamo'
		                    posicion: self center + (150 @ 125).
	self addMorph: formDiasPrestamo.
	"Botón crear"
	self addMorph: (BotonAccion
			 crear: 'Agregar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 250)
			 yFuncion: [ 
				 (sistema agregarBiblioteca: (Biblioteca
						   crearId: formId getText asString asInteger
						   direccion: formDireccion getText asString
						   nombre: formNombre getText asString
						   telefono: formTelefono getText asString
						   nombreRepresentante: formRepresentante getText asString
						   duracionDiasPrestamo: formDiasPrestamo getText asString asInteger))
					 ifTrue: [ 
						 self
							 ventanaNotificacion: '¡Biblioteca creada con éxito!'
							 redirige: [ self menuAgregarBiblioteca ] ]
					 ifFalse: [ 
						 self
							 ventanaNotificacion: 'ID para biblioteca está en uso'
							 redirige: [ self menuAgregarBiblioteca ] ] ])
]

{ #category : #aplicacion }
SistemaVisual >> menuAgregarBibliotecaFav: unUsuario [

	| bibliotecas selector |
	"Obtenemos las bibliotecas que aún no están como favoritas"
	bibliotecas := sistema getBibliotecas.
	self nuevaVentana: [ self menuOpcionesUsuario: unUsuario ] nivel: 5.
	"Título"
	self crearTitulo: unUsuario getNombre , ' ', unUsuario getApellido .
	"Selector bibliotecas"
	selector := self
		            crearSelector: 'Seleccionar biblioteca' lista:
		            (bibliotecas collect: [ :biblioteca | 
			             biblioteca getNombre ])
		            posicion: self center.
	self addMorph: selector.
	self addMorph: (BotonAccion
			 crear: 'Agregar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ 
				 selector selectedItem
					 ifNil: [ 
						 self
							 ventanaNotificacion: '¡Seleccione una biblioteca!'
							 redirige: [ self menuAgregarBibliotecaFav: unUsuario ] ]
					 ifNotNil: [ 
						 unUsuario agregarBibliotecaFav:
							 (sistema getBibliotecas at:
								  selector getCurrentSelectionIndex + 1).
						 self
							 ventanaNotificacion:
							 'Biblioteca ' , selector selectedItem
							 , ' agregada como favorita'
							 redirige: [ self menuOpcionesUsuario: unUsuario ] ] ])
]

{ #category : #aplicacion }
SistemaVisual >> menuAgregarLibro: unaBiblioteca [

	| formId formNombre formEditorial formAnioEdicion selectorTipo formAutores |
	self
		nuevaVentana: [ self menuOpcionesBiblioteca: unaBiblioteca ]
		nivel: 5.
	"Título"
	self crearTitulo: 'Añadir biblioteca'.
	"Formulario id"
	formId := self
		          crearFormulario: 'ID'
		          posicion: self center - (-150 @ 75).
	self addMorph: formId.
	"Formulario nombre"
	formNombre := self
		              crearFormulario: 'Nombre'
		              posicion: self center - (150 @ 75).
	self addMorph: formNombre.
	"Formulario editorial"
	formEditorial := self
		                 crearFormulario: 'Editorial'
		                 posicion: self center + (-150 @ 25).
	self addMorph: formEditorial.
	"Formulario año edición"
	formAnioEdicion := self
		                   crearFormulario: 'Año edición'
		                   posicion: self center + (150 @ 25).
	self addMorph: formAnioEdicion.
	"Selector tipo"
	selectorTipo := self
		                crearSelector: 'Tipo'
		                lista: [ #( 'Físico' 'Digital' 'Audiolibro' ) ]
		                posicion: self center + (-150 @ 125).
	self addMorph: selectorTipo.
	"Formulario autores"
	formAutores := self
		               crearFormulario: 'Autores'
		               posicion: self center + (150 @ 125).
	self addMorph: formAutores.
	"Botón crear"
	self addMorph: (BotonAccion
			 crear: 'Agregar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 250)
			 yFuncion: [ 
				 (unaBiblioteca agregarLibro: (Libro
						   crearId: formId getText asString asInteger
						   nombre: formNombre getText asString
						   editorial: formEditorial getText asString
						   anioEdicion: formAnioEdicion getText asString asInteger
						   tipo: selectorTipo selectedItem
						   colAutores: formAutores getText asString))
					 ifTrue: [ 
						 self
							 ventanaNotificacion: '¡Libro añadido con éxito!'
							 redirige: [ self menuAgregarLibro: unaBiblioteca ] ]
					 ifFalse: [ 
						 self
							 ventanaNotificacion: 'ID para libro está en uso'
							 redirige: [ self menuAgregarLibro: unaBiblioteca ] ] ])
]

{ #category : #aplicacion }
SistemaVisual >> menuAgregarUsuario [

	| formDni formNombre formApellido formContrasenia |
	self nuevaVentana: [ self menuUsuarios ] nivel: 3.
	"Título"
	self crearTitulo: 'Añadir usuario'.
	"Formulario apellido"
	formApellido := self
		                crearFormulario: 'Apellido'
		                posicion: self center - (-150 @ 50).
	self addMorph: formApellido.
	"Formulario nombre"
	formNombre := self
		              crearFormulario: 'Nombre'
		              posicion: self center - (150 @ 50).
	self addMorph: formNombre.
	"Formulario dni"
	formDni := self
		           crearFormulario: 'DNI'
		           posicion: self center + (-150 @ 50).
	self addMorph: formDni.
	"Formulario contraseña"
	formContrasenia := self
		                   crearFormulario: 'Contraseña'
		                   posicion: self center + (150 @ 50).
	self addMorph: formContrasenia.
	"Botón crear"
	self addMorph: (BotonAccion
			 crear: 'Agregar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ 
				 (sistema agregarUsuario: (Usuario
						   crearDni: formDni getText asString asInteger
						   nombre: formNombre getText asString
						   apellido: formApellido getText asString
						   contrasenia: formContrasenia getText asString))
					 ifTrue: [ 
						 self
							 ventanaNotificacion: '¡Usuario creado con éxito!'
							 redirige: [ self menuAgregarUsuario ] ]
					 ifFalse: [ 
						 self
							 ventanaNotificacion: 'DNI para usuario está en uso'
							 redirige: [ self menuAgregarUsuario ] ] ])
]

{ #category : #aplicacion }
SistemaVisual >> menuBibliotecas [

	self nuevaVentana: [ self menuPrincipal ] nivel: 2.
	"Título"
	self crearTitulo: 'Bibliotecas'.
	"Botón crear"
	self addMorph: (BotonAccion
			 crear: 'Agregar biblioteca'
			 color: colorPrincipal
			 posicion: self center - (0 @ 25)
			 yFuncion: [ self menuAgregarBiblioteca ]).
	"Botón buscar"
	self addMorph: (BotonAccion
			 crear: 'Buscar biblioteca'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ self menuBuscarBiblioteca ])
]

{ #category : #aplicacion }
SistemaVisual >> menuBuscarBiblioteca [

	self nuevaVentana: [ self menuBibliotecas ] nivel: 3.
	"Título"
	self crearTitulo: 'Buscar biblioteca'.
	"Mostramos la lista de bibliotecas"
	self crearLista: sistema getBibliotecas bloqueClave: [ :biblioteca | biblioteca getNombre ] bloqueAccion: [ :biblioteca | self menuInfoBiblioteca: biblioteca ]
]

{ #category : #aplicacion }
SistemaVisual >> menuBuscarUsuario [

	self nuevaVentana: [ self menuUsuarios ] nivel: 3.
	"Título"
	self crearTitulo: 'Buscar usuario'.
	"Mostramos la lista de usuarios"
	self
		crearLista: sistema getUsuarios
		bloqueClave: [ :usuario | usuario getNombre , ' ' , usuario getApellido ]
		bloqueAccion: [ :usuario | self menuInfoUsuario: usuario ]
]

{ #category : #aplicacion }
SistemaVisual >> menuInfoBiblioteca: unaBiblioteca [

	self nuevaVentana: [ self menuBuscarBiblioteca ] nivel: 4.
	"Título"
	self crearTitulo: '"' , unaBiblioteca getNombre , '"'.
	"Datos"
	self
		crearTexto: 'Id: ' , unaBiblioteca getId asString
		posicion: self center - (0 @ 100).
	self
		crearTexto: 'Dirección: ' , unaBiblioteca getDireccion
		posicion: self center - (0 @ 50).
	self
		crearTexto: 'Teléfono: ' , unaBiblioteca getTelefono
		posicion: self center.
	self
		crearTexto: 'Representante: ' , unaBiblioteca getNombreRepresentante
		posicion: self center + (0 @ 50).
	self
		crearTexto:
		'Duración préstamo: '
		, unaBiblioteca getDuracionDiasPrestamo asString
		posicion: self center + (0 @ 100).
	"Botón más opciones"
	self addMorph: (BotonAccion
			 crear: 'Opciones'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ self menuOpcionesBiblioteca: unaBiblioteca ])
]

{ #category : #aplicacion }
SistemaVisual >> menuInfoLibro: unLibro biblioteca: unaBiblioteca [

	self nuevaVentana: [ self menuListaLibros: unaBiblioteca ] nivel: 6.
	"Título"
	self crearTitulo: '"' , unLibro getNombre , '"'.
	"Datos"
	self
		crearTexto: 'Id: ' , unLibro getId asString
		posicion: self center - (0 @ 100).
	self
		crearTexto: 'Editorial: ' , unLibro getEditorial
		posicion: self center - (0 @ 50).
	self
		crearTexto: 'Año edición: ' , unLibro getAnioEdicion asString
		posicion: self center.
	self
		crearTexto: 'Tipo: ' , unLibro getTipo asString
		posicion: self center + (0 @ 50).
	self
		crearTexto: 'Disponible: ' , unLibro getDisponibleString
		posicion: self center + (0 @ 100).
	"Botón más opciones"
	self addMorph: (BotonAccion
			 crear: 'Eliminar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ 
				 self
					 ventanaConfirmacion:
						 '¿Eliminar ' , unLibro getNombre , ' de '
						 , unaBiblioteca getNombre , '?'
					 bloqueConfirma: [ 
						 (unaBiblioteca quitarLibro: unLibro)
							 ifTrue: [ 
								 self
									 ventanaNotificacion: '¡' , unLibro getNombre , ' eliminado!'
									 redirige: [ self menuListaLibros: unaBiblioteca ] ]
							 ifFalse: [ 
								 self
									 ventanaNotificacion: 'El libro fue prestado'
									 redirige: [ 
									 self menuInfoLibro: unLibro biblioteca: unaBiblioteca ] ] ]
					 redirige: [ 
					 self menuInfoLibro: unLibro biblioteca: unaBiblioteca ] ])
]

{ #category : #aplicacion }
SistemaVisual >> menuInfoUsuario: unUsuario [

	self nuevaVentana: [ self menuBuscarUsuario ] nivel: 4.
	"Título"
	self crearTitulo: unUsuario getNombre , ' ' , unUsuario getApellido.
	"Datos"
	self
		crearTexto: 'DNI: ' , unUsuario getDni asString
		posicion: self center - (0 @ 50).
	self crearTexto: 'Contraseña: ' , '?' posicion: self center.
	self
		crearTexto: 'Tipo: ' , unUsuario getTipo
		posicion: self center + (0 @ 50).
	"Botón más opciones"
	self addMorph: (BotonAccion
			 crear: 'Opciones'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ self menuOpcionesUsuario: unUsuario ])
]

{ #category : #aplicacion }
SistemaVisual >> menuListaLibros: unaBiblioteca [

	self
		nuevaVentana: [ self menuOpcionesBiblioteca: unaBiblioteca ]
		nivel: 5.
	"Título"
	self crearTitulo: 'Libros de "' , unaBiblioteca getNombre , '"'.
	"Listamos libros"
	self
		crearLista: unaBiblioteca getLibros
		bloqueClave: [ :libro | libro getNombre ]
		bloqueAccion: [ :libro | 
		self menuInfoLibro: libro biblioteca: unaBiblioteca ]
]

{ #category : #aplicacion }
SistemaVisual >> menuOpcionesBiblioteca: unaBiblioteca [

	self nuevaVentana: [ self menuBuscarBiblioteca ] nivel: 4.
	"Título"
	self crearTitulo: '"' , unaBiblioteca getNombre , '"'.
	"Botón agregar material"
	self addMorph: (BotonAccion
			 crear: 'Agregar libro'
			 color: colorPrincipal
			 posicion: self center - (0 @ 100)
			 yFuncion: [ self menuAgregarLibro: unaBiblioteca ]).
	"Botón quitar material"
	self addMorph: (BotonAccion
			 crear: 'Ver libros'
			 color: colorPrincipal
			 posicion: self center
			 yFuncion: [ self menuListaLibros: unaBiblioteca ]).
	"Botón préstamos activos"
	self addMorph: (BotonAccion
			 crear: 'Préstamos activos'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ 
				 self
					 nuevaVentana: [ self menuOpcionesBiblioteca: unaBiblioteca ]
					 nivel: 5.
				 self crearTitulo:
					 'Préstamos activos de "' , unaBiblioteca getNombre , '"'.
				 self
					 crearLista: unaBiblioteca getPrestamos
					 bloqueClave: [ :prestamo | prestamo getUsuario getNombre ]
					 bloqueAccion: [  ] ]).
	"Botón ver datos biblioteca"
	self addMorph: (BotonAccion
			 crear: 'Info biblioteca'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ self menuInfoBiblioteca: unaBiblioteca ])
]

{ #category : #aplicacion }
SistemaVisual >> menuOpcionesUsuario: unUsuario [

	self nuevaVentana: [ self menuBuscarUsuario ] nivel: 4.
	"Título"
	self crearTitulo: unUsuario getNombre , ' ' , unUsuario getApellido.
	"Botón cambiar plan"
	self addMorph: (BotonAccion
			 crear: 'Cambiar plan'
			 color: colorPrincipal
			 posicion: self center - (0 @ 100)
			 yFuncion: [  ]).
	"Botón añadir biblioteca favorita"
	self addMorph: (BotonAccion
			 crear: 'Agregar biblioteca fav'
			 color: colorPrincipal
			 posicion: self center
			 yFuncion: [ self menuAgregarBibliotecaFav: unUsuario ]).
	"Botón préstamos activos"
	self addMorph: (BotonAccion
			 crear: 'Préstamos'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [  ]).
	"Botón ver datos usuario"
	self addMorph: (BotonAccion
			 crear: 'Info usuario'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ self menuInfoUsuario: unUsuario ])
]

{ #category : #aplicacion }
SistemaVisual >> menuPrincipal [

	self nuevaVentana: [  ] nivel: 1.
	"Título"
	self crearTitulo: 'Administrador de bibliotecas'.
	"Botón bibliotecas"
	self addMorph: (BotonAccion
			 crear: 'Bibliotecas'
			 color: colorPrincipal
			 posicion: self center - (0 @ 25)
			 yFuncion: [ self menuBibliotecas ]).
	"Botón usuarios"
	self addMorph: (BotonAccion
			 crear: 'Usuarios'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ self menuUsuarios ])
]

{ #category : #aplicacion }
SistemaVisual >> menuUsuarios [

	self nuevaVentana: [ self menuPrincipal ] nivel: 2.
	"Título"
	self crearTitulo: 'Usuarios'.
	"Botón crear"
	self addMorph: (BotonAccion
			 crear: 'Agregar usuario'
			 color: colorPrincipal
			 posicion: self center - (0 @ 25)
			 yFuncion: [ self menuAgregarUsuario ]).
	"Botón buscar"
	self addMorph: (BotonAccion
			 crear: 'Buscar usuario'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ self menuBuscarUsuario  ])
]

{ #category : #aplicacion }
SistemaVisual >> nuevaVentana: ventanaAnterior nivel: unNivel [

	"Reiniciamos morphs y dibujamos botones escenciales"

	| nivel |
	self removeAllMorphs.
	"Botón atras"
	self addMorph: (BotonAccion
			 crearAuxiliar: 'Volver'
			 color: colorPrincipal
			 posicion: self position
			 yFuncion: ventanaAnterior).
	"Botón salir"
	self addMorph: (BotonAccion
			 crearAuxiliar: 'Salir'
			 color: colorPrincipal
			 posicion: self topRight - (100 @ 0)
			 yFuncion: [ self delete ]).
	"Profundidad de la ventana representada por cantidad de puntos"
	nivel := ''.
	unNivel timesRepeat: [ nivel := nivel , '.' ].
	self addMorph: (StringMorph new
			 contents: nivel;
			 font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 20);
			 emphasis: TextEmphasis bold emphasisCode;
			 color: colorPrincipal;
			 center: self topCenter + (0 @ 25))
]

{ #category : #aplicacion }
SistemaVisual >> ventanaConfirmacion: unaPregunta bloqueConfirma: unBloquePositivo redirige: unMenu [

	| pregunta |
	"Quitamos morphs previos"
	self removeAllMorphs.
	"Mensaje"
	pregunta := StringMorph new.
	pregunta
		contents: unaPregunta;
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 18);
		emphasis: TextEmphasis bold emphasisCode;
		color: colorPrincipal;
		center: self center - (0 @ 100).
	self addMorph: pregunta.
	"Botón confirmar, ejecuta el bloque positivo y redirige al menú"
	self addMorph: (BotonAccion
			 crear: 'Confirmar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 50)
			 yFuncion: unBloquePositivo).
	"Botón cancelar, solo redirige"
	self addMorph: (BotonAccion
			 crear: 'Cancelar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 150)
			 yFuncion: unMenu)
]

{ #category : #aplicacion }
SistemaVisual >> ventanaNotificacion: unTexto redirige: unMenu [

	| texto |
	"Quitamos morphs previos"
	self removeAllMorphs.
	"Mensaje"
	texto := StringMorph new.
	texto
		contents: unTexto;
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 18);
		emphasis: TextEmphasis bold emphasisCode;
		color: colorPrincipal;
		center: self center - (0 @ 50).
	self addMorph: texto.
	"Botón redirección"
	self addMorph: (BotonAccion
			 crear: 'Continuar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 125)
			 yFuncion: unMenu)
]
