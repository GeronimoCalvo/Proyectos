extends CharacterBody2D
var INITIAL_SPEED = 250.0
const SPEED_INCREMENT = 50.0
const SCREEN_WIDTH = 450.0
const Y_POSITION = 50.0

@onready var speed_timer = $Timer  

func _ready() -> void:
	position.x = SCREEN_WIDTH
	position.y = Y_POSITION
	start_timer()
func _incrementar_velocidad() -> void:
	INITIAL_SPEED += SPEED_INCREMENT

func start_timer() -> void:
	speed_timer.start() 

func stop_timer() -> void:
	speed_timer.stop()  
	
func _physics_process(_delta: float) -> void:
	velocity.x = -INITIAL_SPEED
	move_and_slide()
	if position.x < -1100:
		position.x = SCREEN_WIDTH
		position.y = Y_POSITION

func _on_body_entered(body):
	if body.name == "jugador":
		body.die()  
