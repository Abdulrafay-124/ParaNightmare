extends CharacterBody2D

@export var player_speed = 400.0
@export var playerRotationSpeed = 15
var health = 100.0
signal helath_depleted

func _ready() -> void:
	add_to_group("player")

# Easy way to create 8 way movement
func get_input(delta):
	var input_direction = Input.get_vector("left","right","up","down")
	velocity = input_direction * player_speed 

func play_animation(delta):
	
	if Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("walk_front")
	if Input.is_action_just_released("up"):
		$AnimatedSprite2D.play("idle_front")
		
	if Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("walk_back")
	if Input.is_action_just_released("down"):
		$AnimatedSprite2D.play("idle_back")
		
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("walk_left")
	if Input.is_action_just_released("left"):
		$AnimatedSprite2D.play("idle_left")
			
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("walk_right")
	if Input.is_action_just_released("right"):
		$AnimatedSprite2D.play("idle_right")
		
		
func damage(delta):
	const DAMAGE_RATE = 15.0
	var overlapping_enemies = %Hurtbox.get_overlapping_bodies()
	if overlapping_enemies.size() > 0 :
		health -= overlapping_enemies.size() * DAMAGE_RATE * delta
		%ProgressBar.value = health
		if health <= 0:
			helath_depleted.emit()
			
		
	
func _physics_process(delta):
	damage(delta)
	get_input(delta)
	play_animation(delta)
	move_and_slide()
	
# A function that will help a sprite follow mouse position	
#func mouse_pos(delta):
	#var mousePos = get_global_mouse_position()
	#var targetAngle = global_position.angle_to_point(mousePos)
	#rotation = lerp_angle(rotation, targetAngle, playerRotationSpeed * delta)
	
