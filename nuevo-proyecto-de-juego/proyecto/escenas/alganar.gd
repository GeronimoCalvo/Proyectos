extends Control
@onready var ganar = $ganar

func Reaparecer() -> void:
	get_tree().change_scene_to_file("res://escenas/pista.tscn")

func Salir() -> void:
	get_tree().quit()
