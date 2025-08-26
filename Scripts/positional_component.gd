class_name PlayerPositionalCOmponent extends CharacterBody2D

@export var statsheet : StatSheet
@warning_ignore("unused_parameter")
func _process(delta):
	var move_vector : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * statsheet.move_speed
	velocity = move_vector
	move_and_slide()
