extends Node2D

var score = 0
var level = 0
var level_up_threshold = 1000


func spawn_enemies():
	var new_enemy = preload("res://scenes/enemy_1.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	add_child(new_enemy)
	new_enemy.enemy_dead.connect(_on_boos_enemy_dead) # Each enemy that dies emits a signal
	
func _on_timer_timeout() -> void:
	spawn_enemies()

func update_level():
	while score >= level_up_threshold:
		level += 1
		%"Level".text = "Level " + str(level)
		level_up_threshold *= 2
		
		if level == 3:
			get_tree().change_scene_to_file("res://scenes/ending_scene.tscn")
		
		
func _on_player_helath_depleted() -> void:
	%Game_Over.visible = true
	get_tree().paused = true
	
func _on_boos_enemy_dead() -> void:
	score += 10
	%Points.text = str(score)
	%"Total Score".text = "Total Score: " + str(score)
	update_level()

	
func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	


	
