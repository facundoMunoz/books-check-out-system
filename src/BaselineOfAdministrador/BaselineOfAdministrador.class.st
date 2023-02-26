Class {
	#name : #BaselineOfAdministrador,
	#superclass : #BaselineOf,
	#category : #BaselineOfAdministrador
}

{ #category : #baselines }
BaselineOfAdministrador >> baseLine: spec [

	<baseline>
	spec
		for: #pharo
		do: [ "Packages" spec package: 'books-check-out-system' ]
]

{ #category : #accessing }
BaselineOfAdministrador >> projectClass [
^ MetacelloCypressBaselineProject
]
