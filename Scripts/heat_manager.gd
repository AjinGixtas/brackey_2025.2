class_name HeatManager extends Control

@export var heat_cap : float = 30
@export var current_heat : float = 0
@export var normal_heat_bar : TextureProgressBar
@export var overheat_bar : TextureProgressBar
@export var heat_icon : TextureRect
@export var heat_overlay : ColorRect
@export var player : Player
func increase_heat(heat : float):
	current_heat = clamp(current_heat + heat, 0, heat_cap)
	heat_decel = 0
var heat_decel : float = 0
func _process(delta):
	delta /= Engine.time_scale
	current_heat = max(0, current_heat - heat_decel * delta)
	heat_decel += delta * 3
	
	normal_heat_bar.value = move_toward(normal_heat_bar.value, current_heat, delta * 7.5)
	overheat_bar.value = current_heat - normal_heat_bar.max_value
	
	var heat_percentage = current_heat / 10
	
	# Make effects ramp harder above 100%
	var visual_percent = heat_percentage
	if heat_percentage > 1.0:
		# Exponential growth beyond 1.0
		visual_percent = 1.0 + pow(heat_percentage - 1.0, 1.5) * 5.0
		# tuning knobs: ^ exponent controls curve steepness, * multiplier controls boost strength
	
	heat_icon.scale = Vector2.ONE * (0.25 + visual_percent)
	heat_icon.rotation_degrees = (randf() - .5) * 20 * pow(visual_percent, 2)
	heat_overlay.color = Color(1, 0, 0, 0.2 * visual_percent)
