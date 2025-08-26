class_name EXP_Manager extends Control

@export var current_exp : float = 0
@export var exp_limit : float = 32
@export var exp_prog_bar : TextureProgressBar
@export var upgrade_director : UpgradeDirector
@export var animation_player : AnimationPlayer
func _ready():
	exp_prog_bar.max_value = exp_limit
func increase_exp(exp : float):
	current_exp += exp
	animation_player.play("gain_exp")
	exp_prog_bar.value = current_exp
	if current_exp >= exp_limit:
		upgrade_director.pull_up_upgrade()
		current_exp = 0
		exp_prog_bar.value = 0
		exp_limit *= 1.25
		exp_prog_bar.max_value = exp_limit
