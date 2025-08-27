class_name GunDisplayControl extends Node2D
@export var bullet_spawn_point : Node2D
@export var gun_behavior_control : GunBehaviorControl
@export var statsheet : StatSheet
@export var bullet_container : Node2D
@export var gun_sprite : Sprite2D
@export var player : Player
var mouse_pos : Vector2
var can_shoot : bool = true
@export var shoot_timer : Timer
@warning_ignore("unused_parameter")
func _process(delta):
	mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	if Input.is_action_pressed("shoot") && can_shoot:
		shoot()
	gun_sprite.scale = Vector2(4, -4 if gun_sprite.global_position.x < global_position.x else 4)
var bullet_time_table := { "A": .1, "B": .2, "C": .5 }
@export var temp_shooter_scene : PackedScene
func shoot():
	var bullet_data = gun_behavior_control.shoot() # [0] - full bullet_name
	can_shoot = false
	var pellet_count: int = bullet_data[1]
	var bullet_scene: PackedScene = bullet_data[2]
	var shoot_type : String = bullet_data[3]
	var bullet_type = bullet_data[0].split("_")[1]
	shoot_timer.start()
	var temp_shooter : TempShooter = temp_shooter_scene.instantiate()
	if pellet_count <= 0 || bullet_scene == null: 
		push_error("GRAVE ERROR: pellet_count = %s" % str(bullet_data))
	bullet_spawn_point.add_child(temp_shooter)
	temp_shooter.global_rotation = bullet_spawn_point.global_rotation
	
	temp_shooter.position = Vector2(0, 0)
	temp_shooter.init(bullet_scene, pellet_count, shoot_type, statsheet, bullet_container)
	player.heat_manager.increase_heat(bullet_time_table[bullet_type] * pellet_count + .5)
func _on_shoot_timer_timeout():
	can_shoot = true
