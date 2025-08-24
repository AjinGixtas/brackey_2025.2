extends Node2D
@export var bullet_spawn_point : Node2D
@export var gun_behavior_control : GunBehaviorControl
@export var statsheet : StatSheet
@export var bullet_container : Node2D
@export var gun_sprite : Sprite2D
var mouse_pos : Vector2
func _process(delta):
	mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	if Input.is_action_just_pressed("shoot"):
		shoot()
		print("shoot!")
	gun_sprite.scale = Vector2(4, -4 if gun_sprite.global_position.x < global_position.x else 4)
func shoot():
	var bullet_data = gun_behavior_control.shoot() # [0] - Pellet amount, [1] - Bullet scene
	var pellet_count: int = bullet_data[0]
	var bullet_scene: PackedScene = bullet_data[1]

	if pellet_count <= 0 or bullet_scene == null: push_error("CATASTROPHIC ERROR: UNKNOWN ROUND TYPE OR ROUND SHOOT NO BULLET"); return
	
	# Spread scales with pellet count (example: +5° per pellet beyond the first)
	var max_spread_deg: float = max(0, (pellet_count - 1) * 2.0)
	var max_spread_rad: float = deg_to_rad(max_spread_deg)

	# If multiple pellets, spread them evenly across [-max_spread, +max_spread]
	for i in range(pellet_count):
		var t = 0.0 if pellet_count == 1 else float(i) / float(pellet_count - 1) # 0..1
		var offset_angle = lerp(-max_spread_rad, max_spread_rad, t)
		# Instantiate bullet
		var bullet: Bullet = bullet_scene.instantiate()
		bullet.global_position = bullet_spawn_point.global_position
		bullet.global_rotation = bullet_spawn_point.global_rotation + offset_angle
		# Compute direction based on rotation
		var dir = Vector2.RIGHT.rotated(bullet.global_rotation)
		bullet.init(dir, statsheet)
		bullet_container.add_child(bullet)
