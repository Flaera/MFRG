extends Control
#extends Node2D


# Pré-carrega o shader
var contrast_shader = preload("res://scripts/shaders/shader_contrast.tres")


func _ready():
	# Cria e configura o viewport
	var viewport = get_node("ViewportContainer/Viewport")#Viewport.new()
	#viewport.size = Vector2(OS.window_size.x, OS.window_size.y)
	viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	
	var viewport_texture = viewport.get_texture()
	
	# Cria um sprite ou texture rect para exibir o conteúdo do viewport
	var sprite = get_node("TextureRect")#TextureRect.new()
	sprite.rect_min_size = viewport.size
	sprite.texture = viewport_texture
	#add_child(sprite)
	
	# Cria um ColorRect e aplica o shader
	var color_rect = get_node("ViewportContainer/Viewport/ColorRect")#ColorRect.new()
	color_rect.rect_min_size = viewport.size
	var shader_material = get_node("ViewportContainer/Viewport/ColorRect").get("material")#ShaderMaterial.new()
	shader_material.shader = contrast_shader
	color_rect.material = shader_material
	#contrast_shader = shader_material #Linha adicionada para copiar a informação de shader_material
	#viewport.add_child(color_rect)
	
	#add_child(viewport)
	
	# Define o contraste inicial
	set_contrast(1)  # Ajuste o contraste aqui conforme necessário


func set_contrast(value):
	var material = get_node("ViewportContainer/Viewport/ColorRect").get("material")
	if material:
		material.set_shader_param("contrast", value)
	#contrast_shader.set("Viewport/shader_param/contrast", value)
