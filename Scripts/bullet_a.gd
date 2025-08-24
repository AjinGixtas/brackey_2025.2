class_name BulletA extends Bullet
func _process(delta):
	velocity = vel
	move_and_slide()
func _on_hitbox_area_entered(area):
	queue_free()
