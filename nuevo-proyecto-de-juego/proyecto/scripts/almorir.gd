extends Control
@onready var morir = $morir

func Reintentar() -> void:
	get_tree().change_scene_to_file("res://escenas/pista.tscn")

func Salir() -> void:
	get_tree().quit()
