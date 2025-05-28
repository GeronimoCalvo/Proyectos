extends CharacterBody2D

const SPEED = 250.0  # Velocidad de desplazamiento horizontal
const SCREEN_WIDTH = 450.0  # Ancho de la pantalla (ajusta según tu escenario)
const Y_MIN = 50.0  # Límite inferior del eje Y (ajusta según la pista)
const Y_MAX = 150.0  # Límite superior del eje Y (ajusta según la pista)
var vertical_speed = 100.0  # Velocidad base de movimiento vertical
var vertical_direction = 1  # Dirección inicial hacia arriba

func _ready() -> void:
	# Establecer la posición inicial en el lado derecho de la pantalla
	position.x = SCREEN_WIDTH  # Comienza en el lado derecho de la pantalla
	position.y = randf_range(Y_MIN, Y_MAX)  # Establecer una posición Y aleatoria dentro de los límites

func _physics_process(_delta: float) -> void:
	# Definir la velocidad horizontal
	velocity.x = -SPEED  # Mover siempre hacia la izquierda

	# Variar la velocidad vertical aleatoriamente
	vertical_speed = randf_range(100.0, 250.0)  # Rango de velocidad vertical
	velocity.y = vertical_direction * vertical_speed  # Mover en la dirección vertical

	move_and_slide()  # Llamar a move_and_slide sin argumentos

	# Mantener el enemigo dentro de los límites de la pantalla en Y
	if position.y < Y_MIN:  # Si sale por el límite inferior
		position.y = Y_MIN  # Limitar al límite inferior
		vertical_direction = 1  # Cambiar dirección a arriba
	elif position.y > Y_MAX:  # Si sale por el límite superior
		position.y = Y_MAX  # Limitar al límite superior
		vertical_direction = -1  # Cambiar dirección a abajo

	# Cambiar la dirección vertical de forma aleatoria
	if randf() < 0.00000001:  # Aumenta la probabilidad de cambiar de dirección
		vertical_direction *= -1  # Cambiar dirección vertical

	# Reaparecer en la derecha si sale por la izquierda
	if position.x < -1100:  # Ajusta este valor según el tamaño del enemigo
		position.x = SCREEN_WIDTH  # Reiniciar posición a la derecha
		position.y = randf_range(Y_MIN, Y_MAX)  # Establecer una nueva posición Y aleatoria dentro de los límites

func _on_body_entered(body):
	# Verificar si el cuerpo colisionado es el jugador, comparando el nombre del nodo
	if body.name == "jugador":
		body.die()  # Llama al método de muerte del jugador
