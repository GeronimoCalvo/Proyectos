extends Node2D

@onready var label_vidas = $Label2  # Referencia al Label de vidas
@onready var label_monedas = $Label3  # Referencia al Label de monedas
@onready var jugador = $jugador  # Referencia al nodo del jugador
@onready var limite_label = $Limite2  # Referencia al Label que muestra el aviso de límite alcanzado

func _ready() -> void:
	_actualizar_label_vidas(3)  # Inicializar con 3 vidas
	_actualizar_label_monedas(0)  # Inicializar con 0 monedas
	limite_label.hide()  # Esconde el aviso de límite al inicio

	# Conectar señales del jugador
	if jugador:
		jugador.connect("vidas_actualizadas", Callable(self, "_actualizar_label_vidas"))
		jugador.connect("monedas_actualizadas", Callable(self, "_actualizar_label_monedas"))
		jugador.connect("limite_alcanzado", Callable(self, "_mostrar_aviso_limite"))  # Conexión con la señal limite_alcanzado
	else:
		print("No se pudo encontrar el nodo 'jugador'.")

# Actualiza el label de las vidas
func _actualizar_label_vidas(vidas_restantes: int) -> void:
	label_vidas.text = ": " + str(vidas_restantes)

# Actualiza el label de monedas
func _actualizar_label_monedas(nuevo_contador: int) -> void:
	label_monedas.text = ": " + str(nuevo_contador)  # Actualiza el label de monedas

# Muestra el aviso de límite alcanzado
func _mostrar_aviso_limite() -> void:
	limite_label.show()  # Muestra el mensaje
	await get_tree().create_timer(0.5).timeout  # Espera 0.5 segundos
	limite_label.hide()  # Esconde el mensaje después de 0.5 segundos
