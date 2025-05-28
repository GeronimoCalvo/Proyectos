extends TileMap

var speed = 125  # Velocidad de movimiento de las líneas
var tile_width = 0  # Ancho de una celda del TileMap
var contador_monedas = 0
	
func _ready() -> void:
	# Asegúrate de que haya un TileSet asignado
	if tile_set:
		tile_width = tile_set.tile_size.x  # Obtén el ancho de una celda
	else:
		print("Error: No hay TileSet asignado al TileMap.")

func _process(delta: float) -> void:
	move_tilemap(delta)

func move_tilemap(delta: float) -> void:
	# Mueve el TileMap hacia la izquierda
	position.x -= speed * delta

	# Reinicia la posición del TileMap si ha salido de la pantalla
	if position.x < -tile_width:
		position.x += tile_width  # Reubica al principio
