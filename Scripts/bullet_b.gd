class_name BulletB extends Bullet
@warning_ignore("unused_parameter")
func _process(delta):
	velocity = vel * 2
	move_and_slide()
@warning_ignore("unused_parameter")
func _on_hitbox_area_entered(area : Area2D):
	if not area.is_in_group("Wall"): return
	queue_free()
