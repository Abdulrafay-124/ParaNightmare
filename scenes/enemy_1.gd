extends CharacterBody2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
signal enemy_dead

var health = 100
var speed = 200
var is_dead = false

func take_damage():
	if is_dead:
		return

	health -= 20
	$AnimatedSprite2D.play("hurt")
	if health <= 0:
		die()
		
func die():
	is_dead = true
	speed = 0
	$AnimatedSprite2D.play("death")
	enemy_dead.emit()
	queue_free()
	
		
		
		
func _physics_process(delta):
	
	if is_dead:
		return
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk_right")
	else:
		$AnimatedSprite2D.flip_h = true
		
	move_and_slide()
