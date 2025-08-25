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
@export var temp_shooter_scene : PackedScene
func shoot():
	var bullet_data = gun_behavior_control.shoot() # [0] - Pellet amount, [1] - Bullet scene
	var pellet_count: int = bullet_data[0]
	var bullet_scene: PackedScene = bullet_data[1]
	var shoot_type : String = bullet_data[2]
	var temp_shooter : TempShooter = temp_shooter_scene.instantiate()
	if pellet_count <= 0 or bullet_scene == null: push_error("CATASTROPHIC ERROR: UNKNOWN ROUND TYPE OR ROUND SHOOT NO BULLET"); return
	temp_shooter.init(bullet_scene, pellet_count, shoot_type, statsheet, bullet_container)
	bullet_spawn_point.add_child(temp_shooter)
