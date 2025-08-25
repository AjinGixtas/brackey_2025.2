class_name EnemyDirector extends Node2D
@export var player : Player
@export var crawlie_scene : PackedScene
@export var start_marker : Marker2D
@export var end_marker : Marker2D

var enemies : Array = []
func _ready():
	enemies = [
		{ "scene":crawlie_scene, "pts": 1, "weight": 7 },
	]
	enemies.sort_custom(func(a, b): return a["pts"] < b["pts"])
	# --- TEST CODE START HERE ---
	for i in range(1):
		var crawlie_instance : Crawlie = enemies[0]["scene"].instantiate()
		crawlie_instance.init(self, 0)
		add_child(crawlie_instance)
	# --- TEST CODE END HERE ---
func _process(delta):
	# Update points in system
	amount_of_pts_in_sys = clampf(
		amount_of_pts_in_sys + delta * amount_of_pts_in_sys_gen_speed, 
		0, amount_of_pts_in_sys_cap
	)
	
	# Calculate available budget for spawning
	var budget : float = min(
		amount_of_pts_in_game_cap - amount_of_pts_in_game, 
		amount_of_pts_in_sys, 
		amount_of_pts_transfer_cap
	)

	# Try to spawn an enemy if possible
	if budget >= enemies[0]["pts"]: _spawn_enemy(budget)
	#print(amount_of_pts_in_game, ' ', amount_of_pts_in_sys, ' ', amount_of_pts_in_game_cap, ' ', amount_of_pts_in_sys_cap, ' ', amount_of_pts_in_sys_gen_speed, ' ', amount_of_pts_transfer_cap)


func _spawn_enemy(budget: float) -> void:
	var candidates = []
	for e in enemies:
		if e["pts"] > budget: break
		candidates.append(e)
	if candidates.is_empty(): return # nothing affordable

	# Weighted random pick
	var total_weight = 0
	for e in candidates: total_weight += e["weight"]

	var roll = randi_range(1, total_weight)
	var chosen = null
	for e in candidates:
		roll -= e["weight"]
		if roll > 0: continue
		chosen = e; break
	if chosen == null: return # should not happen

	# Spawn the enemy
	var inst = chosen["scene"].instantiate()
	inst.init(self, chosen["pts"])
	var spawn_pos = Vector2(randf_range(start_marker.global_position.x, end_marker.global_position.x), 
		randf_range(start_marker.global_position.y, end_marker.global_position.y))
	var HARD_CAP = 32; var i = 0;
	while spawn_pos.distance_squared_to(player.global_position) < 32400 and i < HARD_CAP:
		spawn_pos = Vector2(randf_range(start_marker.global_position.x, end_marker.global_position.x), 
		randf_range(start_marker.global_position.y, end_marker.global_position.y))
		i += 1
	add_child(inst)


	inst.global_position = spawn_pos
	# Deduct pts
	amount_of_pts_in_sys -= chosen["pts"]
	amount_of_pts_in_game += chosen["pts"]

var amount_of_pts_in_game : float = 0
var amount_of_pts_in_sys : float = 0

var amount_of_pts_in_game_cap : float = 64
var amount_of_pts_in_sys_cap : float = 32
var amount_of_pts_in_sys_gen_speed : float = 5
var amount_of_pts_transfer_cap : float = 1
