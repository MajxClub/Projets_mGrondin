extends KinematicBody2D

onready var animated_sprite = get_node("animated") # permet d'utiliser dans ce codes des références au noeaud "animated"
var speed = 300
var direction = Vector2.ZERO

func _process(delta: float) -> void: # relance chaque frame (indispensable avant les mouvements)
	move_and_slide(direction * speed)

func _input(event : InputEvent) -> void: # déplacement du personnage dans 4 directions
	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	direction = direction.normalized() # évite d'aller trop vite en marchant en diagonale
	
	match(direction): # utilise onready var animated sprite, sert à modifier les animations
		Vector2.ZERO:
			animated_sprite.stop()
			animated_sprite.set_frame(0)
		Vector2.RIGHT: animated_sprite.play("moveright")
		Vector2.LEFT: animated_sprite.play("moveleft")
		Vector2.DOWN: animated_sprite.play("movedown")
		Vector2.UP: animated_sprite.play("moveup")
		
############ ici autre verion plus lourde des mouvements (foret de if) #################
#	if direction == Vector2.ZERO:
#		animated_sprite.stop()
#		animated_sprite.set_frame(0)
#	if direction == Vector2.RIGHT: # utilise onready var animated sprite, sert à modifier les animations
#		animated_sprite.play("moveright")
#	if direction == Vector2.LEFT:
#		animated_sprite.play("moveleft")
#	if direction == Vector2.DOWN:
#		animated_sprite.play("movedown")
#	if direction == Vector2.UP:
#		animated_sprite.play("moveup")


