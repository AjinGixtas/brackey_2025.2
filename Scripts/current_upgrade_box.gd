class_name CurrentUpgradeBox extends Control
@export var upgrade_director : UpgradeDirector
@export var btn_idx : int
const SHOT_TYPE := ["A", "B", "C"] # A - Normal, B - Pierce, C - Explosive
const SHOT_NUMB := ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
const FIRE_TYPE := ["!", "@", "#"] # ! - Blast, @ - Spray, # Burst
const base_type := { "A": 1.0, "B": 1.2, "C": 1.5 }
const base_fire := { "!": 1.3, "@": 1.0, "#": 1.1 }
var picked_round_idx : int
var round_strength : float
@export var label : RichTextLabel
func _ready():
	init()
func init():
	picked_round_idx = randi_range(0, len(upgrade_director.player.gun_behavior_control.mag_bullets) - 1)
	round_strength = calculate_strength(upgrade_director.player.gun_behavior_control.mag_bullets[picked_round_idx])
	var round_name := upgrade_director.player.gun_behavior_control.mag_bullets[picked_round_idx]
	label.text = "%s\n%s" % [round_name, str(round_strength)]

func calculate_strength(name: String) -> float:
	var parts := name.split("_")
	var shot_numb := int(parts[0]); var shot_type := parts[1]; var fire_type := parts[2]
	var hash = name.hash() % 2048; var random_offset = (float(hash) / 1000.0) * 0.2 + 0.9
	return (shot_numb * 10.0) * base_type[shot_type] * base_fire[fire_type] * random_offset
