extends KinematicBody2D

const GRAVITY = 1000 # constance = ne peut pas être modifée
const UP = Vector2(0, -1) # indique que le "sol" est en bas de l'écran

var vel = Vector2() # les variable déclarée tout en haut du code sont globales au code
var speed = 200
var dirx = 0
onready var animated_sprite = get_node("AnimatedSprite2")

#func _ready():
#	add_to_group("enemy")
#	randomize()
#	set_physics_process(false)

func _on_StompDetector_body_entered(_body : KinematicBody2D) -> void:
#	$AudioMonstre.play()
	emit_signal("touch")
#	Manager.hit = Manager.hit +1
#	print(Manager.hit)
#	yield(get_tree().create_timer(0.5), "timeout") 
	_body.bounce() # fait sauter le hréos (+avoir ajouer fonction bounce au héros)
	queue_free()

func _on_Timer_timeout():
	var m = int (rand_range(0, 10))
	if m < 5 :
		dirx = -1
	elif m > 5 :
		dirx = 1
	else:
		dirx = 0

func _physics_process(delta): # (meilleure version de func _process) execute 60 ticks par seconde
	vel.x = 0 # a chaque frame la vitesse revient à zéro
	vel.y += GRAVITY * delta # delta = temps écoulé depuis le dernière frame, utile pour stabiliser le code

	movement_loop() # indique au code d'aller voir le fonction movement loop
	move_and_slide(vel, UP) # aide pour avoir la gravité

func movement_loop(): # les mouvements du character sont gérés ici
	var right = (dirx == 1)
	var left = (dirx == -1)
	if dirx == -1 :
		vel.x -= speed
	elif dirx == 1 :
		vel.x += speed
	elif is_on_floor():
		vel.y = -300
	
	if is_on_wall():
		dirx += -1
	if right: #ici je gère les différentes animations
		animated_sprite.play("mobright")
	if left:
		animated_sprite.play("mobleft")

func _on_KillTouch_body_entered(_body : KinematicBody2D) -> void:
	get_tree().change_scene("res://GameOver.tscn")
