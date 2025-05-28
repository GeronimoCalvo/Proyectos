extends Node2D

# Función para continuar el juego
func continuar() -> void:
	print("Se ha llamado a la función continuar()")
	get_tree().paused = false  # Despausa el juego
	get_tree().change_scene_to_file("res://escenas/nivel2.tscn")  # Vuelve al nivel 2
# Función para reiniciar el juego
func volver_al_menu() -> void:
	print("Reiniciando a la escena de menú")
	get_tree().change_scene_to_file("res://escenas/menu.tscn")

# Función para salir del juego
func salir() -> void:
	print("Saliendo del juego")
	get_tree().quit()
