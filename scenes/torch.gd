extends Area2D

var torch_rotation_speed = 15
@onready var torch: AnimatedSprite2D = $"torch pivot/Torch"
@onready var torch_light: AnimationPlayer = $"torch pivot/Torch/light/Torch_light/AnimationPlayer"
@onready var collision_shape_2d: CollisionShape2D = $"/root/world/Player/Torch/torch pivot/Torch/light/Torch_light/CollisionShape2D"


	
# A function that will help a sprite follow mouse position	
func mouse_pos(delta):
	
	if Input.is_action_pressed("aim"):
		var mousePos = get_global_mouse_position()
		var targetAngle = global_position.angle_to_point(mousePos)
		rotation = lerp_angle(rotation, targetAngle, torch_rotation_speed * delta)
		
		if Input.is_action_pressed("fire"):
			torch.play("on")
			torch_light.play("shine")
			collision_shape_2d.set_deferred("disabled", false) 
		else:
			collision_shape_2d.set_deferred("disabled", true)
			torch.play("off")
	
func _process(delta: float) -> void:
	mouse_pos(delta)
