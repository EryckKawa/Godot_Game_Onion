extends CharacterBody2D

const SPEED = 200.0
const JUMP_FORCE = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
@onready var jump_sound = $jumpsound

@onready var animation:= $anim as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
		jump_sound.play()
	elif is_on_floor():
		is_jumping = false

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
		if !is_jumping:
			animation.play("run")
		else:
			animation.play("jump")
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and !is_jumping:
			animation.play("idle")
		else:
			animation.play("jump")

	move_and_slide()






func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemies"):
		queue_free()

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
