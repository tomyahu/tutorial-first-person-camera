extends KinematicBody


# Sensibilidad horizontal
export var h_sensibilidad = 0.0005

# Sensibilidad vertical
export var v_sensibilidad = 0.001

# Velocidad de caminata
export var velocidad = 10

# Esta funcion se corre al inicio
func _ready():
	# Hacer que el mouse este capturado en el centro de la pantalla y sea invisible
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Esta funcion nos permite ver cuando el mouse se se mueve
func _input(event):
	# Parte del codigo que se encarga de mover la camara
	if event is InputEventMouseMotion:
		# Rotamos al jugador horizontalmente
		rotate_y( - event.relative.x * h_sensibilidad )
		
		# Rotamos la camara que posee el jugador verticalmente
		$Camera.rotate_x( - event.relative.y * v_sensibilidad )


# Esta funcion se llama cada frame
func _process(delta):
	var vel_actual = Vector3(0, 0, 0)
	
	# velocidad hacia adelante y atras
	if Input.is_action_pressed("ui_up"):
		vel_actual.z -= velocidad
	if Input.is_action_pressed("ui_down"):
		vel_actual.z += velocidad
	
	# velocidad hacia la izquierda y derecha
	if Input.is_action_pressed("ui_left"):
		vel_actual.x -= velocidad
	if Input.is_action_pressed("ui_right"):
		vel_actual.x += velocidad
	
	# Hacemos que el vector "vel_actual" apunte hacia donde estamos mirando horizontalmente para desplazarnos hacia alla
	vel_actual = vel_actual.rotated( Vector3(0, 1, 0), rotation.y )
	
	# Nos movemos en la direccion vel_actual
	move_and_slide( vel_actual )
