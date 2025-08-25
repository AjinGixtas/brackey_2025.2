class_name CurrentUpgradeBox extends Control
@export var upgrade_director : UpgradeDirector
@export var idx : int
var picked_bullet_idx : int
func init():
	picked_bullet_idx = randi_range(0, len(upgrade_director.player.gun_behavior_control.mag_bullets) - 1)
	
