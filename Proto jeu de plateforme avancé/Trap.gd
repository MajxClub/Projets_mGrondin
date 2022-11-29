extends KinematicBody2D

#const GRAVITY = 1000 # constance = ne peut pas être modifée
#const UP = Vector2(0, -1) # indique que le "sol" est en bas de l'écran

#var vel = Vector2() # les variable déclarée tout en haut du code sont globales au code
#var speed = 200
#var dirx = 0

#func _ready():
#	add_to_group("enemy")
#	randomize()
#	set_physics_process(false)

#func _physics_process(delta): # (meilleure version de func _process) execute 60 ticks par seconde
#	vel.x = 0 # a chaque frame la vitesse revient à zéro
#	vel.y += GRAVITY * delta # delta = temps écoulé depuis le dernière frame, utile pour stabiliser le code


func _on_Area2D_body_entered(_body : KinematicBody2D) -> void:
	get_tree().change_scene("res://GameOver.tscn")
