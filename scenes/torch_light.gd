extends Area2D

func _ready() -> void:
	print(get_path())

func _process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	
	
	

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
