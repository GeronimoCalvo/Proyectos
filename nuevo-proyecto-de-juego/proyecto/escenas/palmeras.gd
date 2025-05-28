extends Node2D

var speed = 200  # Velocidad de movimiento hacia la izquierda

func _process(delta: float) -> void:
	# Mueve el nodo hacia la izquierda
	position.x -= speed * delta

	# Si el nodo sale de la pantalla, reinícialo en la posición opuesta
	if position.x < -1000:  # Ajusta este valor según el tamaño de tu pantalla
		position.x = get_viewport().size.x + randf() * 150  # Reaparece en la derecha con un desplazamiento aleatorio
