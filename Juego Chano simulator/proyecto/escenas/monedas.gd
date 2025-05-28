extends Area2D

# Constantes
var INITIAL_SPEED = 250.0  # Velocidad inicial
const SPEED_INCREMENT = 50.0  # Incremento de velocidad
const SCREEN_WIDTH = 1100.0  # Ancho de la pantalla

# Nodo Timer
@onready var speed_timer = $Timer  

func _ready() -> void:
	reiniciar_posicion()
	connect("body_entered", Callable(self, "_on_body_entered"))
	
	# Inicializar el temporizador para incrementar velocidad
	start_timer()

func _process(_delta: float) -> void:
	position.x -= INITIAL_SPEED * _delta
	if position.x < -1150:
		reiniciar_posicion()

func _on_body_entered(body):
	if body.name == "jugador":
		body.sumar_moneda()  # Sumar moneda al jugador
		reiniciar_posicion()  # Reaparecer la moneda

func reiniciar_posicion():
	position.x = SCREEN_WIDTH

# Incrementar velocidad
func _incrementar_velocidad() -> void:
	INITIAL_SPEED += SPEED_INCREMENT

# Manejo del temporizador
func start_timer() -> void:
	speed_timer.start()

func stop_timer() -> void:
	speed_timer.stop()
