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
	formulario := RubTextFieldMorph new
		              textFont:
			              (LogicalFont
				               familyName: 'Source Sans Pro'
				               pointSize: 14);
		              backgroundColor: colorPrincipal;
		              extent: 250 @ 0;
		              center: unaPosicion.
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
	self color: Color white.
	self bounds: (self position extent: 600 @ 600).
	colorPrincipal := Color r: 71 / 255 g: 90 / 255 b: 105 / 255.
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

	| formularioId biblioteca |
	self nuevaVentana: [ self menuBibliotecas ] nivel: 3.
	"Título"
	self crearTitulo: 'Buscar biblioteca'.
	"Formulario de la id"
	formularioId := self
		                crearFormulario: 'ID'
		                posicion: self center - (0 @ 25).
	self addMorph: formularioId.
	"Botón buscar"
	self addMorph: (BotonAccion
			 crear: 'Buscar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ 
				 biblioteca := sistema getBiblioteca:
					               formularioId getText asString asInteger.
				 biblioteca ifNotNil: [ self menuInfoBiblioteca: biblioteca ] ])
]

{ #category : #aplicacion }
SistemaVisual >> menuBuscarUsuario [

	| formularioDni usuario |
	self nuevaVentana: [ self menuUsuarios ] nivel: 3.
	"Título"
	self crearTitulo: 'Buscar usuario'.
	"Formulario del dni"
	formularioDni := self
		                 crearFormulario: 'DNI'
		                 posicion: self center - (0 @ 25).
	self addMorph: formularioDni.
	"Botón buscar"
	self addMorph: (BotonAccion
			 crear: 'Buscar'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [ 
				 usuario := sistema getUsuario:
					            formularioDni getText asString asInteger.
				 usuario ifNotNil: [ self menuInfoUsuario: usuario ] ])
]

{ #category : #aplicacion }
SistemaVisual >> menuInfoBiblioteca: unaBiblioteca [

	self nuevaVentana: [ self menuBuscarBiblioteca ] nivel: 4.
	"Título"
	self crearTitulo: '"' , unaBiblioteca getNombre , '"'.
	"Datos"
	self
		crearTexto: 'Id: ' , unaBiblioteca getId asString
		posicion: self center - (0 @ 125).
	self
		crearTexto: 'Dirección: ' , unaBiblioteca getDireccion
		posicion: self center - (0 @ 75).
	self
		crearTexto: 'Teléfono: ' , unaBiblioteca getTelefono
		posicion: self center - (0 @ 25).
	self
		crearTexto: 'Representante: ' , unaBiblioteca getNombreRepresentante
		posicion: self center + (0 @ 25).
	self
		crearTexto:
		'Duración préstamo: '
		, unaBiblioteca getDuracionDiasPrestamo asString
		posicion: self center + (0 @ 75).
	"Botón más opciones"
	self addMorph: (BotonAccion
			 crear: 'Más opciones'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ self menuOpcionesBiblioteca: unaBiblioteca ])
]

{ #category : #aplicacion }
SistemaVisual >> menuInfoUsuario: unUsuario [

	self nuevaVentana: [ self menuBuscarUsuario ] nivel: 4.
	"Título"
	self crearTitulo: unUsuario getNombre, ' ', unUsuario getApellido.
	"Datos"
	self
		crearTexto: 'DNI: ' , unUsuario getDni asString
		posicion: self center - (0 @ 25).
	self
		crearTexto: 'Contraseña: ' , '?'
		posicion: self center + (0 @ 25).
	"Botón más opciones"
	self addMorph: (BotonAccion
			 crear: 'Más opciones'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [  ])
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
			 yFuncion: [  ]).
	"Botón quitar material"
	self addMorph: (BotonAccion
			 crear: 'Quitar libro'
			 color: colorPrincipal
			 posicion: self center
			 yFuncion: [  ]).
	"Botón prestamos activos"
	self addMorph: (BotonAccion
			 crear: 'Préstamos activos'
			 color: colorPrincipal
			 posicion: self center + (0 @ 100)
			 yFuncion: [  ]).
	"Botón ver datos biblioteca"
	self addMorph: (BotonAccion
			 crear: 'Info biblioteca'
			 color: colorPrincipal
			 posicion: self center + (0 @ 200)
			 yFuncion: [ self menuInfoBiblioteca: unaBiblioteca ])
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
			 crearAuxiliar: 'Atras'
			 color: colorPrincipal
			 posicion: self topRight - (100 @ 0)
			 yFuncion: ventanaAnterior).
	"Botón salir"
	self addMorph: (BotonAccion
			 crearAuxiliar: 'Salir'
			 color: colorPrincipal
			 posicion: self position
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

{ #category : #testing }
SistemaVisual >> plantilla [

	| titulo formLabel form |
	"Crear título"
	titulo := StringMorph new.
	titulo
		contents: 'ADMINISTRADOR';
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 18);
		emphasis: TextEmphasis bold emphasisCode;
		color: colorPrincipal;
		center: self topCenter + (0 @ 50).

	"Crear formulario"
	form := RubTextFieldMorph new.
	self borderColor: Color black.
	form
		textFont: (LogicalFont familyName: 'Source Sans Pro' pointSize: 14);
		backgroundColor: colorPrincipal;
		extent: 300 @ 0;
		center: self center.
	"Creamos el label"
	formLabel := StringMorph new.
	formLabel
		contents: 'Nombre:';
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 14);
		emphasis: TextEmphasis bold emphasisCode;
		color: colorPrincipal;
		position: form topLeft - formLabel bottomLeft.
	self addMorph: formLabel.

	"Dibujamos en la ventana"
	self addMorph: titulo.
	self addMorph: (BotonAccion
			 crear: 'CREAR'
			 color: colorPrincipal
			 posicion: self center + self bottomCenter / 2
			 yFuncion: [ "UIManager default message: 'Nombre: ' , form getText asString"
			  ]).
	self addMorph: form
]

{ #category : #testing }
SistemaVisual >> testMorph [

	| titulo visible botonVisible |
	"El título comienza visible"
	visible := true.
	"Crear título"
	titulo := StringMorph new
		          contents: 'ADMINISTRADOR';
		          font:
			          (LogicalFont familyName: 'Source Sans Pro' pointSize: 18);
		          emphasis: TextEmphasis bold emphasisCode;
		          color: colorPrincipal;
		          center: self topCenter + (0 @ 50).
	"Creamos botón"
	botonVisible := BotonAccion new.
	botonVisible := BotonAccion
		                crear: 'O'
		                color: colorPrincipal
		                posicion: self center + self bottomCenter / 2
		                yFuncion: [ 
			                visible
				                ifTrue: [ 
					                titulo center: self topCenter - (0 @ 50).
					                visible := false ]
				                ifFalse: [ 
					                titulo center: self topCenter + (0 @ 50).
					                visible := true ] ].
	"Dibujamos en la ventana"
	self addMorph: titulo.
	self addMorph: botonVisible
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
