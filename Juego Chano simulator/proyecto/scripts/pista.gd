extends Node2D

@onready var victory_label = $victoria  # Label de victoria
@onready var label_vidas = $vidas
@onready var label_monedas = $monedas
@onready var jugador = $jugador
@onready var limite_label = $Limite  # Label para mensaje de límite
@onready var timer = $Timer  # Cambié el nombre de "Timer" a "timer"

func _ready() -> void:
	victory_label.hide()  # Esconder el label de victoria al inicio
	limite_label.hide()  # Esconder el mensaje de límite al inicio
	_actualizar_vidas_jugador(3)  # Inicializar con 3 vidas
	_actualizar_label_monedas(0)  # Inicializar con 0 monedas

	# Conectar señales del jugador
	if jugador:
		jugador.connect("vidas_actualizadas", Callable(self, "_actualizar_vidas_jugador"))
		jugador.connect("monedas_actualizadas", Callable(self, "_actualizar_label_monedas"))
		jugador.connect("limite_alcanzado", Callable(self, "_mostrar_aviso_limite"))  # Nueva señal
	else:
		print("Error: El nodo jugador no está conectado correctamente.")
	
	# El Timer no necesita conexión explícita, lo manejamos directamente en la función

func _actualizar_vidas_jugador(vidas_restantes: int) -> void:
	label_vidas.text = ": " + str(vidas_restantes)

func _actualizar_label_monedas(nuevo_contador: int) -> void:
	label_monedas.text = ": " + str(nuevo_contador)

	# Verificación de monedas para mostrar el label de victoria
	if nuevo_contador == 5:
		_mostrar_victoria()

# Función para mostrar el label de victoria antes de cambiar de nivel
func _mostrar_victoria() -> void:
	victory_label.show()  # Mostrar el label de victoria
	timer.start(1.0)  # Iniciar el timer para esperar 2 segundos
	timer.connect("timeout", Callable(self, "_cambiar_a_nivel2"))

# Función para cambiar a nivel 2
func _cambiar_a_nivel2() -> void:
	get_tree().change_scene_to_file("res://escenas/Nivel2.tscn")  # Cambiar a la escena del nivel 2

# Función para mostrar el aviso del límite
func _mostrar_aviso_limite() -> void:
	limite_label.show()
	await get_tree().create_timer(0.5).timeout  # Mostrar el mensaje por 1 segundo
	limite_label.hide()  # Esconder el mensaje
