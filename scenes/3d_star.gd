extends Node3D

@onready var anim = $Star/AnimationPlayer
@onready var world = $WorldEnvironment
@onready var model = $Star



var grad_text = GradientTexture1D.new()
var grad = Gradient.new()

func _ready():
	anim.current_animation = "rotate"
	

func set_prop(star_data):
	model.scale = Vector3(star_data["scale"], star_data["scale"], star_data["scale"])

	#grad.set_color(1, col)
	
	#grad_text.gradient = grad
	
	model.set_surface_override_material(0, star_data["mat"])
	
	$GPUParticles3D.draw_pass_1.material = star_data["mat"]
	
	#world.environment.adjustment_color_correction = grad_text
