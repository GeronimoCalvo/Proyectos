extends CharacterBody2D

const MOVE_SPEED = 300.0
var vidas = 3  # Número de vidas iniciales del jugador
@onready var motor = $motor
@onready var start_position = position  # Guarda la posición inicial para reiniciar
var contador_monedas = 0  # Contador de monedas

# Señales
signal vidas_actualizadas(vidas_restantes)
signal monedas_actualizadas(contador_monedas)
signal limite_alcanzado  # Nueva señal para indicar que se alcanzó el límite

func _ready() -> void:
	emit_signal("vidas_actualizadas", vidas)  # Emitir el estado inicial de vidas
	emit_signal("monedas_actualizadas", contador_monedas)  # Emitir el estado inicial de monedas

func _physics_process(_delta: float) -> void:
	velocity.y = Input.get_axis("ui_up", "ui_down") * MOVE_SPEED
	velocity.x = Input.get_axis("ui_left", "ui_right") * MOVE_SPEED
	move_and_slide()

	# Limitar la posición del jugador en el nivel
	if get_tree().current_scene.name == "pista":  # Nivel 1
		if position.x >= 258:
			position.x = 258
			emit_signal("limite_alcanzado")  # Emitir señal si llega al límite
	elif get_tree().current_scene.name == "Nivel2":  # Nivel 2
		if position.x >= 250:
			position.x = 250
			emit_signal("limite_alcanzado")  # Emitir señal si llega al límite

	# Verificar colisiones
	for i in range(get_slide_collision_count()):
		var collided_body = get_slide_collision(i).get_collider()
		if collided_body and collided_body.name in ["enemigo2", "enemigos", "CharacterBody2D", "obstaculo2", "obstaculo3", "enemigo3", "obstaculos"]:
			die()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):  # Detecta si se presionó Escape
		if get_tree().current_scene.name == "pista":  # Nivel 1
			get_tree().change_scene_to_file("res://escenas/menu pausa.tscn")
		elif get_tree().current_scene.name == "Nivel2":  # Nivel 2
			get_tree().change_scene_to_file("res://escenas/menu pausa2.tscn")


func die():
	vidas -= 1
	emit_signal("vidas_actualizadas", vidas)  # Notificar cambio de vidas
	reset_position()
	
	if vidas == 0:
		morir()

func reset_position():
	position = start_position
	velocity = Vector2.ZERO

func morir():
	if get_tree():
		get_tree().change_scene_to_file("res://escenas/almorir.tscn")

func sumar_moneda() -> void:
	contador_monedas += 1
	emit_signal("monedas_actualizadas", contador_monedas)  # Notificar cambio de monedas
		
	if contador_monedas == 5 and get_tree().current_scene.name == "Nivel2":
		get_tree().change_scene_to_file("res://escenas/alganar.tscn")
