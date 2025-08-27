class_name HealthManager extends Control
@export var health_display_textures : Array[TextureRect]
const full_heart_texture := preload("res://Arts/heart_full.png")
const empt_heart_texture := preload("res://Arts/heart_empty.png")
var curr_health : int = 5
var max_health : int = 5
func change_health(delta : int) -> void:
	curr_health = clamp(curr_health + delta, 0, max_health)
	for i in range(curr_health):
		health_display_textures[i].texture = full_heart_texture
	for i in range(max_health - curr_health):
		health_display_textures[curr_health + i].texture = empt_heart_texture
