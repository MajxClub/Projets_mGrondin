extends KinematicBody2D

export (int) var run_speed = 400
export (int) var jump_speed = -600
export (int) var gravity = 1000

onready var animated_sprite = get_node("AnimatedSprite") # permet d'utiliser dans ce codes des références au noeaud "animated"
var velocity = Vector2()
var jumping = false
var direction = Vector2.ZERO

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')
	
	##### ANIMATIONS #####
	if Input.is_action_pressed('ui_right') and is_on_floor():
		animated_sprite.play ("walkright")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed('ui_left') and is_on_floor():
		$AnimatedSprite.flip_h = true
		animated_sprite.play ("walkright")
	elif Input.is_action_pressed('ui_right') and Input.is_action_pressed ('ui_select'):
		animated_sprite.play ("jumpright")
	elif Input.is_action_pressed('ui_left') and Input.is_action_pressed ('ui_select'):
		animated_sprite.play ("jumpright")
	elif Input.is_action_pressed('ui_select') :
		animated_sprite.play ("jumpright")
	elif Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	else:
			animated_sprite.play ("idle")
	
	###### SAUTER #####
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))

func bounce():
	velocity.y = jump_speed * 0.4
	$AudioSaut.play()
#func _on_Area2D_body_entered(body):
#func _on_Player_body_entered(body):  
#	hide() # Player disappears after being hit.  
#	emit_signal("hit")  
#	$CollisionShape2D.disabled = true
	#ou
#	if "enemy" in body.name:
#		get_tree().quit()
