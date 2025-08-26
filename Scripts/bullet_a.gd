class_name BulletA extends Bullet
@warning_ignore("unused_parameter")
func _process(delta):
	velocity = vel
	move_and_slide()
@warning_ignore("unused_parameter")
func _on_hitbox_area_entered(area):
	queue_free()
