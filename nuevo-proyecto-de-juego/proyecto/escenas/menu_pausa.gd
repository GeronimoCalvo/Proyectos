extends Node2D

func continuar() -> void:
	print("Se ha llamado a la función continuar()")  
	get_tree().paused = false  
	get_tree().change_scene_to_file("res://escenas/pista.tscn")  
	
func volver_al_menu() -> void:
	print("Volviendo al menú principal") 
	get_tree().paused = false  
	get_tree().change_scene_to_file("res://escenas/menu.tscn")  

func salir() -> void:
	print("Saliendo del juego")  
	get_tree().quit()
