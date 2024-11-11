extends KinematicBody

var vidas = 100
var pontos = 0
var municao = 20

var sensibilidade = 0.4
var angulominimo = -90
var angulomaximo = 90

var vmovimento = 5
var gravidade = 1.62
var fpulo = 4

onready var camera = get_node("Camera")
var vel : Vector3 = Vector3()
var vmouse : Vector2 = Vector2()

onready var localtiro = get_node("Camera/arma/bala")
onready var bala = preload("res://Scenes/Bala.tscn")
onready var hud = get_node("/root/Main/HUD")  

func _ready():
	$tema.play()
	hud.atualizavidas(vidas)
	hud.atualizapontos(pontos)
	hud.atualizamunicao(municao)

func _input(event):
	if event is InputEventMouseMotion:
		vmouse = event.relative
	if Input.is_action_just_pressed("tiro"):
		atira()
		
		
func atira():
	if municao > 0:
		$tiro.play()
		var novabala = bala.instance()
		get_node("/root/Main").add_child(novabala)
		novabala.global_transform = localtiro.global_transform
		novabala.scale = Vector3.ONE
		municao -= 1
		hud.atualizamunicao(municao)
		
func _process(delta):
	camera.rotation_degrees -= Vector3(rad2deg(vmouse.y), 0, 0) * sensibilidade * delta
	
	
	camera.rotation_degrees.x - clamp(camera.rotation_degrees.x, angulominimo, angulomaximo)
	
	rotation_degrees -= Vector3(0, rad2deg(vmouse.x), 0) * sensibilidade * delta
	
	vmouse = Vector2()

func _physics_process(delta):
	vel.x = 0
	vel.z = 0
	var input = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		input.y -= 1
		
	if Input.is_action_pressed("ui_down"):
		input.y += 1
		
	if Input.is_action_pressed("ui_left"):
		input.x -= 1
		
	if Input.is_action_pressed("ui_right"):
		input.x += 1
		
	input = input.normalized()
	
	var frente = global_transform.basis.z
	var direita = global_transform.basis.x
	
	vel.y -= gravidade * delta
	
	vel.z = (frente * input.y + direita * input.x).z * vmovimento
	vel.x = (frente * input.y + direita * input.x).x * vmovimento
	
	vel = move_and_slide(vel, Vector3.UP)
	
	if Input.is_action_pressed("pulo") and is_on_floor():
		vel.y = fpulo

func toma_pontos(ganhou):
	pontos += ganhou
	$morteinimigo.play()
	hud.atualizapontos(pontos)
	
	
func toma_vida(quanto):
	vidas += quanto
	$vidas.play()
	hud.atualizavidas(vidas)
	
	
func toma_dano(dano):
	vidas -= dano
	$dano.play()
	hud.atualizavidas(vidas)
	if vidas == 0:
		morre()
		
		
func morre():
	hud.perde()

func toma_municao(quanto):
	municao += quanto
	$municao.play()
	hud.atualizamunicao(municao)
