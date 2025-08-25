class_name TempShooter extends Node2D

var bullet_scene : PackedScene
var pellet_count : int
var shoot_type : String
var statsheet : StatSheet
var bullet_container : Node2D

const CONE_SPREAD := "!"
const SPRAY := "@"
const BURST := "#"
const TIME_TO_SHOOT : float = 60.0 / 900.0

var time2shoot_counter : float = 0
var spray_counter : int = 0
var burst_counter : int = 0
var burst_remaining : int = 0

@warning_ignore("shadowed_variable")
func init(bullet_scene : PackedScene, pellet_count : int, shoot_type : String, statsheet : StatSheet, bullet_container : Node2D):
	self.bullet_scene = bullet_scene
	self.pellet_count = pellet_count
	self.shoot_type = shoot_type
	self.statsheet = statsheet
	self.bullet_container = bullet_container

	match shoot_type:
		CONE_SPREAD: shoot_cone()
		SPRAY, BURST: pass

func _process(delta: float) -> void:
	match shoot_type:
		SPRAY: shoot_spray(delta)
		BURST: shoot_burst(delta)

# ---------------- BULLET SPAWNING ----------------

func spawn_bullet(angle_offset: float = 0.0) -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation + angle_offset
	var dir = Vector2.RIGHT.rotated(bullet.global_rotation)
	bullet.init(dir * statsheet.bullet_speed, statsheet)
	bullet_container.add_child(bullet)

# ---------------- SHOOTING PATTERNS ----------------

func shoot_cone() -> void:
	var max_spread_rad := deg_to_rad(max(0, (pellet_count - 1) * 2.0))
	for i in range(pellet_count):
		var t : float = 0.0 if pellet_count == 1 else float(i) / float(pellet_count - 1)
		var offset : float = lerp(-max_spread_rad, max_spread_rad, t)
		spawn_bullet(offset)
	queue_free()
func shoot_spray(delta: float) -> void:
	time2shoot_counter += delta
	if time2shoot_counter < TIME_TO_SHOOT: return
	time2shoot_counter -= TIME_TO_SHOOT

	var offset := randf_range(-spray_counter, spray_counter) * 0.05
	spawn_bullet(offset)
	spray_counter += 1
	if spray_counter >= pellet_count: queue_free()
func shoot_burst(delta: float) -> void:
	time2shoot_counter += delta
	if time2shoot_counter < TIME_TO_SHOOT: return
	time2shoot_counter -= TIME_TO_SHOOT

	var to_shoot : int = min(5, pellet_count - burst_counter)
	if to_shoot <= 0: queue_free(); return

	var max_spread_rad := deg_to_rad(max(0, (to_shoot - 1) * 2.0))
	for i in range(to_shoot):
		var t : float = 0.0 if to_shoot == 1 else float(i) / float(to_shoot - 1)
		var offset : float = lerp(-max_spread_rad, max_spread_rad, t)
		spawn_bullet(offset)

	burst_counter += to_shoot
	if burst_counter >= pellet_count:
		queue_free()
