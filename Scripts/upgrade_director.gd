class_name UpgradeDirector extends CanvasLayer
@export var player : Player
@export var enemy_director : EnemyDirector
@export var selected_new_upgrade : int
@export var selected_old_upgrade : int
@export var current_upgrade_boxes : Array[CurrentUpgradeBox] = []
@export var upgrade_selection_boxes : Array[UpgradeSelectionBox] = []
var wave_per_health_increase := 5
var curr_wave := 1
func pull_up_upgrade():
	animation_player.play("pull_up_upgrade")
func init():
	selected_new_upgrade = -1
	selected_old_upgrade = -1
	for i in range(3):
		current_upgrade_boxes[i].init()
		upgrade_selection_boxes[i].init()
	curr_wave += 1
	if (curr_wave % wave_per_health_increase == 0): enemy_director.enemy_health += 1
func init_2():
	Engine.time_scale = .1
	
func select_new_upgrade(idx : int) -> void:
	selected_new_upgrade = idx
	print(selected_old_upgrade, '!', selected_new_upgrade)
	if selected_old_upgrade != -1:
		swap_upgrade()
func select_old_upgrade(idx : int) -> void:
	selected_old_upgrade = idx
	print(selected_old_upgrade, ' ', selected_new_upgrade)
	if selected_new_upgrade != -1:
		swap_upgrade()
@export var animation_player : AnimationPlayer
func swap_upgrade():
	var old_round_idx := current_upgrade_boxes[selected_old_upgrade].picked_round_idx
	var new_round_val := upgrade_selection_boxes[selected_new_upgrade].round_name
	var pow_diff = abs(current_upgrade_boxes[selected_old_upgrade].round_strength - upgrade_selection_boxes[selected_new_upgrade].round_strength)
	player.gun_behavior_control.mag_bullets[old_round_idx] = new_round_val
	enemy_director.amount_of_pts_in_sys_gen_speed += pow_diff * .5
	enemy_director.amount_of_pts_in_game_cap += pow_diff * .5
	enemy_director.amount_of_pts_in_sys_cap += pow_diff * .5
	print(pow_diff)
	animation_player.play_backwards("pull_down_upgrade")
	bullet_swapped.emit()
func finish():
	Engine.time_scale = 1
signal bullet_swapped
