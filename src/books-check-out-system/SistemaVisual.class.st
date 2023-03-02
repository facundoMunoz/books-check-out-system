"
Morph encargado de administrar toda la parte visual del sistema, siendo ésta la clase que se llama para iniciarlo

###Ejemplo de creación vacío:
```
SistemaVisual crear
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

{ #category : #construction }
SistemaVisual class >> crear [

	self new openInWindowLabeled: 'Sistema'.
]

{ #category : #construction }
SistemaVisual class >> crearConDatos [

	self new cargaInicialPrueba openInWindowLabeled: 'Sistema'
]

{ #category : #private }
SistemaVisual >> cargaInicialPrueba [

	sistema cargaInicialPrueba
]

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

	| tamanioLista scroll scrollContents point |
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
		| elementoActual |
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
	fuente := (LogicalFont familyName: 'Source Sans Pro' pointSize: 13) 
		          emphasis: TextEmphasis bold emphasisCode.
	selector := DropListMorphColored
		            on: listaOpciones
		            list: #value
		            selected: nil
		            changeSelected: nil.
	selector
		extent: 250 @ 28;
		selectionColor: colorPrincipal;
		font: fuente;
		listFont: fuente;
		center: unaPosicion;
		setColor: colorPrincipal.
	listaOpciones isEmpty ifFalse: [ selector listSelectionIndex: 1 ].
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
	"Estilo de la ventana"
	colorPrincipal := Color r: 71 / 255 g: 90 / 255 b: 105 / 255.
	self borderColor: colorPrincipal.
	self color: (Color r: 255 / 255 g: 251 / 255 b: 241 / 255).
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
	self crearTitulo: unUsuario getNombre , ' ' , unUsuario getApellido.
	"Selector bibliotecas"
	selector := self
		            crearSelector: 'Seleccionar biblioteca'
		            lista:
		            (bibliotecas collect: [ :biblioteca | 
			             biblioteca getNombre ])
		            posicion: self center.
	self addMorph: selector.
	self addMorph: (BotonAccion
			 crear: 'Agregar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ 
						 | bibliotecaSeleccionada |
						 bibliotecaSeleccionada := sistema getBibliotecas at:
							                           selector listSelectionIndex.
						 (unUsuario getBibliotecasFavoritas indexOf:
							  bibliotecaSeleccionada) = 0
							 ifFalse: [ 
								 self
									 ventanaNotificacion:
									 '¡' , selector selectedItem
									 , ' ya es una biblioteca favorita!'
									 redirige: [ self menuAgregarBibliotecaFav: unUsuario ] ]
							 ifTrue: [ 
								 unUsuario agregarBibliotecaFav: bibliotecaSeleccionada.
								 self
									 ventanaNotificacion:
									 'Biblioteca ' , selector selectedItem
									 , ' agregada como favorita'
									 redirige: [ self menuAgregarBibliotecaFav: unUsuario ] ] ])
]

{ #category : #aplicacion }
SistemaVisual >> menuAgregarLibro: unaBiblioteca [

	| formId formNombre formEditorial formAnioEdicion selectorTipo formAutores |
	self
		nuevaVentana: [ self menuOpcionesBiblioteca: unaBiblioteca ]
		nivel: 5.
	"Título"
	self crearTitulo: 'Añadir libro'.
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
		                lista:
		                (OrderedCollection withAll:
			                 #( 'Físico' 'Digital' 'Audiolibro' ))
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
SistemaVisual >> menuBuscarPrestamo: unaListaPrestamos bloqueClave: bloqueClave menuAnterior: unMenuAnterior [

	self nuevaVentana: unMenuAnterior nivel: 5.
	"Título"
	self crearTitulo: 'Préstamos activos'.
	"Listamos préstamos"
	self
		crearLista: unaListaPrestamos
		bloqueClave: bloqueClave
		bloqueAccion: [ :prestamo | 
			self menuInfoPrestamo: prestamo ventanaListaAnterior: [ 
				self
					menuBuscarPrestamo: unaListaPrestamos
					bloqueClave: bloqueClave
					menuAnterior: unMenuAnterior ] ]
]

{ #category : #aplicacion }
SistemaVisual >> menuBuscarPrestamoUsuario: unaListaPrestamos usuario: unUsuario bloqueClave: bloqueClave menuAnterior: unMenuAnterior [

	self nuevaVentana: unMenuAnterior nivel: 5.
	"Título"
	self crearTitulo: 'Préstamos activos'.
	"Listamos préstamos"
	self
		crearLista: unaListaPrestamos
		bloqueClave: bloqueClave
		bloqueAccion: [ :prestamo | 
			self menuInfoPrestamo: prestamo ventanaListaAnterior: [ 
				self
					menuBuscarPrestamoUsuario: (sistema getPrestamosUsuario: unUsuario)
					usuario: unUsuario
					bloqueClave: bloqueClave
					menuAnterior: unMenuAnterior ] ]
]

{ #category : #aplicacion }
SistemaVisual >> menuBuscarUsuario [

	self nuevaVentana: [ self menuUsuarios ] nivel: 3.
	"Título"
	self crearTitulo: 'Buscar usuario'.
	"Mostramos la lista de usuarios"
	self
		crearLista: sistema getUsuarios
		bloqueClave: [ :usuario | 
		usuario getNombre , ' ' , usuario getApellido ]
		bloqueAccion: [ :usuario | self menuConfirmarUsuario: usuario ]
]

{ #category : #aplicacion }
SistemaVisual >> menuCambioPlanUsuario: unUsuario [

	self nuevaVentana: [ self menuOpcionesUsuario: unUsuario ] nivel: 5.
	"Según el tipo de usuario debemos hacer un cambio o el otro"
	unUsuario getTipo = 'Plus'
		ifTrue: [ 
			self
				ventanaConfirmacion: '¿Desea dejar de ser Plus?'
				bloqueConfirma: [ 
					| nuevoRegular |
					"Quitamos el plus"
					sistema quitarUsuario: unUsuario.
					"Agregamos el regular"
					nuevoRegular := unUsuario asUsuarioRegular.
					sistema agregarUsuario: nuevoRegular.
					self menuInfoUsuario: nuevoRegular ]
				redirige: [ self menuOpcionesUsuario: unUsuario ] ]
		ifFalse: [ 
			| formNroTarjeta formCodSeguridad |
			self crearTitulo: 'Cambio a Plus'.
			formNroTarjeta := self
				                  crearFormulario: 'Número de tarjeta:'
				                  posicion: self center - (0 @ 50).
			self addMorph: formNroTarjeta.
			formCodSeguridad := self
				                    crearFormulario: 'Código de seguridad:'
				                    posicion: self center + (0 @ 50).
			self addMorph: formCodSeguridad.
			self addMorph: (BotonAccion
					 crear: 'Cambiar a Plus'
					 color: colorPrincipal
					 posicion: self center + (0 @ 150)
					 yFuncion: [ 
						 | nuevoPlus |
						 "Quitamos el regular"
						 sistema quitarUsuario: unUsuario.
						 "Agregamos el plus"
						 nuevoPlus := unUsuario
							              asUsuarioPlusTarjeta:
							              formNroTarjeta getText asString asInteger
							              codigoSeguridad:
							              formCodSeguridad getText asString asInteger.
						 sistema agregarUsuario: nuevoPlus.
						 self
							 ventanaNotificacion:
							 '¡' , nuevoPlus getNombre , ' ahora es Plus!'
							 redirige: [ self menuInfoUsuario: nuevoPlus ] ]) ]
]

{ #category : #aplicacion }
SistemaVisual >> menuConfirmarUsuario: unUsuario [

	| formContrasenia |
	self nuevaVentana: [ self menuBuscarUsuario ] nivel: 4.
	"Título"
	self crearTitulo: unUsuario getNombre , ' ' , unUsuario getApellido.
	"Pedimos la contraseña"
	formContrasenia := self
		                   crearFormulario: 'Ingrese la contraseña'
		                   posicion: self center.
	self addMorph: formContrasenia.
	"Botón ingresar"
	self addMorph: (BotonAccion
			 crear: 'Ingresar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ 
				 formContrasenia getText asString = unUsuario getContrasenia
					 ifTrue: [ self menuInfoUsuario: unUsuario ]
					 ifFalse: [ 
						 self
							 ventanaNotificacion: 'Contraseña incorrecta'
							 redirige: [ self menuConfirmarUsuario: unUsuario ] ] ]).
	self addMorph: (BotonAccion
			 crear: 'DEBUG: entrar directo'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ self menuInfoUsuario: unUsuario ])
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
SistemaVisual >> menuInfoPrestamo: unPrestamo ventanaListaAnterior: unaVentana [

	self nuevaVentana: unaVentana nivel: 6.
	"Título"
	self crearTitulo: 'Préstamo'.
	"Datos"
	self
		crearTexto: 'Usuario: ' , unPrestamo getUsuario getNombre , ' '
			, unPrestamo getUsuario getApellido
		posicion: self center - (0 @ 75).
	self
		crearTexto: 'Biblioteca: ' , unPrestamo getBiblioteca getNombre
		posicion: self center - (0 @ 25).
	self
		crearTexto: 'Fecha realizado: ' , unPrestamo getFechaInicio asString
		posicion: self center + (0 @ 25).
	self addMorph: (self
			 crearSelector: 'Libros'
			 lista:
			 (unPrestamo getLibros collect: [ :libro | libro getNombre ])
			 posicion: self center + (0 @ 90)).
	"Botón devolver"
	self addMorph: (BotonAccion
			 crear: 'Devolver préstamo'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ 
				 self
					 ventanaConfirmacion: '¿Devolver préstamo?'
					 bloqueConfirma: [ 
					 unPrestamo getBiblioteca devolverPrestamo: unPrestamo getUsuario.
					self ventanaNotificacion: '¡Préstamo devuelto!' redirige: unaVentana ]
					 redirige: [ self menuInfoPrestamo: unPrestamo ventanaListaAnterior: unaVentana ] ])
]

{ #category : #aplicacion }
SistemaVisual >> menuInfoUsuario: unUsuario [

	self nuevaVentana: [ self menuBuscarUsuario ] nivel: 4.
	"Título"
	self crearTitulo: unUsuario getNombre , ' ' , unUsuario getApellido.
	"Datos"
	self
		crearTexto: 'DNI: ' , unUsuario getDni asString
		posicion: self center - (0 @ 125).
	self
		crearTexto: 'Contraseña: ' , unUsuario getContrasenia
		posicion: self center - (0 @ 75).
	self
		crearTexto: 'Tipo: ' , unUsuario getTipo
		posicion: self center - (0 @ 25).
	unUsuario getTipo = 'Plus' ifTrue: [ 
		self
			crearTexto: 'Fecha pago: ' , unUsuario getFechaPago asString
			posicion: self center + (0 @ 25).
		self
			crearTexto:
			'Número de tarjeta: ' , unUsuario getNroTarjeta asString
			posicion: self center + (0 @ 75).
		self
			crearTexto:
			'Código de seguridad: ' , unUsuario getCodSeguridad asString
			posicion: self center + (0 @ 125) ].
	"Botón más opciones"
	self addMorph: (BotonAccion
			 crear: 'Opciones'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ self menuOpcionesUsuario: unUsuario ])
]

{ #category : #aplicacion }
SistemaVisual >> menuLibrosPrestamoUsuario: unUsuario biblioteca: unaBiblioteca [

	| librosBiblioteca librosSeleccionados selectorAgregado selectorActuales |
	"Obtenemos las bibliotecas que aún no están como favoritas"
	librosBiblioteca := unaBiblioteca getLibros select: [ :libro | 
		                    libro getDisponible ].
	librosSeleccionados := OrderedCollection new.
	self
		nuevaVentana: [ self menuNuevoPrestamoUsuario: unUsuario ]
		nivel: 5.
	"Título"
	self crearTitulo: unUsuario getNombre , ' ' , unUsuario getApellido.
	"Ver seleccionados"
	selectorActuales := self
		                    crearSelector: 'Libros seleccionados'
		                    lista:
		                    (librosSeleccionados collect: [ :libro | 
			                     libro getNombre ])
		                    posicion: self center + (150 @ -50).
	self addMorph: selectorActuales.
	self addMorph: (BotonAccion
			 crear: 'Eliminar actual'
			 color: colorPrincipal
			 posicion: self center + (150 @ 50)
			 yFuncion: [ 
				 selectorActuales selectedItem ifNotNil: [ 
					 librosSeleccionados removeAt:
						 selectorActuales listSelectionIndex.
					 librosSeleccionados isEmpty
						 ifFalse: [ "Actualizamos la lista"
							 selectorActuales list:
								 (librosSeleccionados collect: [ :libro | libro getNombre ]).
							 selectorActuales listSelectionIndex: 1 ]
						 ifTrue: [ 
						 self
							 menuLibrosPrestamoUsuario: unUsuario
							 biblioteca: unaBiblioteca ] ] ]).
	"Selector libros"
	selectorAgregado := self
		                    crearSelector: 'Libros disponibles'
		                    lista:
		                    (librosBiblioteca collect: [ :biblioteca | 
			                     biblioteca getNombre ])
		                    posicion: self center - (150 @ 50).
	self addMorph: selectorAgregado.
	self addMorph: (BotonAccion
			 crear: 'Agregar seleccionado'
			 color: colorPrincipal
			 posicion: self center - (150 @ -50)
			 yFuncion: [ 
				 selectorAgregado selectedItem
					 ifNil: [ 
						 self
							 ventanaNotificacion:
							 '¡' , unaBiblioteca getNombre , ' no tiene libros!'
							 redirige: [ 
							 self
								 menuLibrosPrestamoUsuario: unUsuario
								 biblioteca: unaBiblioteca ] ]
					 ifNotNil: [ 
						 | libroNuevo |
						 libroNuevo := librosBiblioteca at:
							               selectorAgregado listSelectionIndex.
						 (librosSeleccionados indexOf: libroNuevo) = 0
						 & (librosSeleccionados size < 5) ifTrue: [ 
							 librosSeleccionados add: libroNuevo.
							 "Actualizamos la lista"
							 selectorActuales
								 list:
									 (librosSeleccionados collect: [ :libro | libro getNombre ]);
								 listSelectionIndex: librosSeleccionados size ] ] ]).
	"Crear préstamo"
	self addMorph: (BotonAccion
			 crear: 'Crear préstamo'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ 
				 librosSeleccionados isEmpty
					 ifTrue: [ 
						 self
							 ventanaNotificacion: '¡Agregue al menos un libro!'
							 redirige: [ 
							 self
								 menuLibrosPrestamoUsuario: unUsuario
								 biblioteca: unaBiblioteca ] ]
					 ifFalse: [ 
						 (unaBiblioteca
							  registrarPrestamo: unUsuario
							  libros: librosSeleccionados)
							 ifTrue: [ 
								 self
									 ventanaNotificacion: '¡Préstamo realizado con éxtito!'
									 redirige: [ self menuOpcionesPrestamoUsuario: unUsuario ] ]
							 ifFalse: [ 
								 self
									 ventanaNotificacion: 'Debe ser Plus para seleccionar Audiolibros'
									 redirige: [ 
									 self
										 menuLibrosPrestamoUsuario: unUsuario
										 biblioteca: unaBiblioteca ] ] ] ])
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
SistemaVisual >> menuNuevoPrestamoUsuario: unUsuario [

	| bibliotecasFav selector |
	"Obtenemos las bibliotecas que aún no están como favoritas"
	bibliotecasFav := unUsuario getBibliotecasFavoritas.
	self
		nuevaVentana: [ self menuOpcionesPrestamoUsuario: unUsuario ]
		nivel: 5.
	"Título"
	self crearTitulo: unUsuario getNombre , ' ' , unUsuario getApellido.
	"Selector bibliotecas"
	selector := self
		            crearSelector: 'Seleccionar biblioteca'
		            lista:
		            (bibliotecasFav collect: [ :biblioteca | 
			             biblioteca getNombre ])
		            posicion: self center.
	self addMorph: selector.
	self addMorph: (BotonAccion
			 crear: 'Seleccionar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ 
				 | bibliotecaSeleccionada |
				 bibliotecaSeleccionada := bibliotecasFav at:
					                           selector listSelectionIndex.
				 (bibliotecaSeleccionada tienePrestamoActivo: unUsuario)
					 ifTrue: [ self ventanaNotificacion: 'Ya tiene un préstamo en ', bibliotecaSeleccionada getNombre redirige: [ self menuNuevoPrestamoUsuario: unUsuario ] ]
					 ifFalse: [ 
						 self
							 menuLibrosPrestamoUsuario: unUsuario
							 biblioteca: bibliotecaSeleccionada ] ])
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
					 menuBuscarPrestamo: unaBiblioteca getPrestamos
					 bloqueClave: [ :prestamo | prestamo getUsuario getNombre, ' ', prestamo getUsuario getApellido ]
					 menuAnterior: [ self menuOpcionesBiblioteca: unaBiblioteca ] ]).
	"Botón ver datos biblioteca"
	self addMorph: (BotonAccion
			 crear: 'Info biblioteca'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ self menuInfoBiblioteca: unaBiblioteca ])
]

{ #category : #aplicacion }
SistemaVisual >> menuOpcionesPrestamoUsuario: unUsuario [

	self nuevaVentana: [ self menuBuscarUsuario ] nivel: 4.
	"Título"
	self crearTitulo: unUsuario getNombre , ' ' , unUsuario getApellido.
	"Botón cambiar plan"
	self addMorph: (BotonAccion
			 crear: 'Crear préstamo'
			 color: colorPrincipal
			 posicion: self center - (0 @ 100)
			 yFuncion: [ 
				 unUsuario getBibliotecasFavoritas isEmpty
					 ifTrue: [ 
						 self
							 ventanaNotificacion:
							 '¡Debe agregar una biblioteca favorita primero!'
							 redirige: [ self menuOpcionesPrestamoUsuario: unUsuario ] ]
					 ifFalse: [ self menuNuevoPrestamoUsuario: unUsuario ] ]).
	"Botón añadir biblioteca favorita"
	self addMorph: (BotonAccion
			 crear: 'Préstamos activos'
			 color: colorPrincipal
			 posicion: self center
			 yFuncion: [ 
				 self
					 menuBuscarPrestamoUsuario: (sistema getPrestamosUsuario: unUsuario)
					 usuario: unUsuario
					 bloqueClave: [ :prestamo | prestamo getBiblioteca getNombre ]
					 menuAnterior: [ self menuOpcionesPrestamoUsuario: unUsuario ] ]).
	"Botón préstamos activos"
	self addMorph: (BotonAccion
			 crear: 'Otras opciones'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ self menuOpcionesUsuario: unUsuario ]).
	"Botón ver datos usuario"
	self addMorph: (BotonAccion
			 crear: 'Info usuario'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ self menuInfoUsuario: unUsuario ])
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
			 yFuncion: [ self menuCambioPlanUsuario: unUsuario ]).
	"Botón añadir biblioteca favorita"
	self addMorph: (BotonAccion
			 crear: 'Agregar biblioteca fav'
			 color: colorPrincipal
			 posicion: self center
			 yFuncion: [ 
				 sistema getBibliotecas isEmpty
					 ifTrue: [ 
						 self
							 ventanaNotificacion: '¡No hay bibliotecas cargadas!'
							 redirige: [ self menuOpcionesUsuario: unUsuario ] ]
					 ifFalse: [ self menuAgregarBibliotecaFav: unUsuario ] ]).
	"Botón préstamos activos"
	self addMorph: (BotonAccion
			 crear: 'Préstamos'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ self menuOpcionesPrestamoUsuario: unUsuario ]).
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
	"Botón confirmar, ejecuta el bloque positivo"
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
