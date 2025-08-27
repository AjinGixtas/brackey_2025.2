class_name GunBehaviorControl extends Node
var bullet_progress : int = 0
var max_bullet : int = 12
var mag_bullets : Array[String] = []
@export var bulletA_scene : PackedScene
@export var bulletB_scene : PackedScene
@export var bulletC_scene : PackedScene
@export var player : Player
var bullet_type_table : Dictionary
@export var bullet_round_display : PackedScene

func _ready():
	bullet_type_table = Dictionary()
	bullet_type_table["A"] = bulletA_scene
	bullet_type_table["B"] = bulletB_scene
	bullet_type_table["C"] = bulletC_scene
	for i in range(max_bullet):
		var bullet_name = "1_A_!"
		mag_bullets.append(bullet_name)
	mag_bullets.shuffle()
	for i in range(max_bullet):
		var inst = bullet_round_display.instantiate()
		inst.init(self, i)
		player.bullet_display.billboard_container.add_child(inst)
func shoot():
	if bullet_progress == max_bullet - 1: 
		mag_bullets.shuffle()
		for i in range(max_bullet):
			var inst = bullet_round_display.instantiate()
			inst.init(self, i)
			player.bullet_display.billboard_container.add_child(inst)
	player.bullet_display.billboard_container.get_child(0).self_remove()
	var next_bullet : String = mag_bullets[bullet_progress]
	bullet_progress = (bullet_progress + 1) % max_bullet
	var parts = next_bullet.split("_")
	if parts.size() < 3:
		push_error("Invalid bullet format: %s" % next_bullet)
		return ["", -117, null, parts]
	var pellet_amount : int = parts[0].to_int()
	var bullet_type : String = parts[1]
	var spray_type : String = parts[2]
	var pellet_scene : PackedScene = bullet_type_table.get(bullet_type, null)
	if pellet_scene == null: pellet_amount = 0
	return [next_bullet, pellet_amount, pellet_scene, spray_type]
