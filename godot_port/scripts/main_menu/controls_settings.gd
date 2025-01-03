extends Control


onready var actions_list = $CanvasLayer/PainelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList
onready var b_up: bool = false
onready var b_down: bool = false
onready var b_right: bool = false
onready var b_left: bool = false
onready var b_nitro: bool = false
onready var b_brake: bool = false
onready var name_controller: String = "CONTROLLER"
onready var res_settings: Resource
const STATIC_AXIS_VALUE: float = 0.00000


func _ready():
	$CanvasLayer/PainelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList/Up.grab_focus()
	set_process_unhandled_key_input(false)
	set_process_unhandled_input(false)
	set_process_input(false)
	set_process(false)
	set_physics_process(false)
	set_physics_process_internal(false)
	display_keys()
	set_actions_names()
	#get_parent().get_parent().get_parent().get_node("ControlMenu/ControlSettings/ViewportContainer").queue_free()
	#get_parent().get_parent().get_parent().get_node("ControlMenu/ControlSettings/TextureRect").queue_free()
	res_settings = ResourceLoader.load("res://resources/game_settings/game_settings.tres")
	



func set_actions_names():
	actions_list.get_node("Up/HBoxContainer/LabelAction").text = "B_UP_FRONT"
	actions_list.get_node("Down/HBoxContainer/LabelAction").text = "B_DOWN_REVERSE"
	actions_list.get_node("Right/HBoxContainer/LabelAction").text = "B_RIGHT"
	actions_list.get_node("Left/HBoxContainer/LabelAction").text = "B_LEFT"
	actions_list.get_node("Nitro/HBoxContainer/LabelAction").text = "B_NITRO"
	actions_list.get_node("Brake/HBoxContainer/LabelAction").text = "B_BRAKE"


func convert_actions2bnames(action):
	if (action is InputEventJoypadButton):
		print("act=",action.button_index)
		if (action.button_index==JOY_START):
			return name_controller+" "+"START"
		elif (action.button_index==JOY_SELECT):
			return name_controller+" "+"SELECT"
		elif (action.button_index==JOY_XBOX_A):
			return name_controller+" "+"A/CROSS"
		elif (action.button_index==JOY_XBOX_B):
			return name_controller+" "+"B/CIRCLE"
		elif (action.button_index==JOY_XBOX_X):
			return name_controller+" "+"X/SQUARE"
		elif (action.button_index==JOY_XBOX_Y):
			return name_controller+" "+"Y/TRIANGLE"
		elif (action.button_index==12):
			return name_controller+" "+"ARROW UP"
		elif (action.button_index==13):
			return name_controller+" "+"ARROW DOWN"
		elif (action.button_index==14):
			return name_controller+" "+"ARROW LEFT"
		elif (action.button_index==15):
			return name_controller+" "+"ARROW RIGHT"
		elif (action.button_index==9):
			return name_controller+" "+"RIGHT AXIS BUTTON"
		elif (action.button_index==8):
			return name_controller+" "+"LEFT AXIS BUTTON"
		elif (action.button_index==4):
			return name_controller+" "+"L2"
		elif (action.button_index==5):
			return name_controller+" "+"R2"
		else:
			return name_controller+" "+"UNABLE INPUT. TRY AGAIN."
	elif (action is InputEventJoypadMotion):
		print("act2=",action.axis,"|", action.axis_value)
		#action.axis_value=STATIC_AXIS_VALUE
		if (action.axis==3 and action.axis_value<STATIC_AXIS_VALUE):
			return name_controller+" "+"UP IN RIGHT AXIS"
		elif (action.axis==3 and action.axis_value>STATIC_AXIS_VALUE):
			return name_controller+" "+"DOWN IN RIGHT AXIS"
		elif (action.axis==2 and action.axis_value>STATIC_AXIS_VALUE):
			return name_controller+" "+"RIGHT IN RIGHT AXIS"
		elif (action.axis==2 and action.axis_value<STATIC_AXIS_VALUE):
			return name_controller+" "+"LEFT IN RIGHT AXIS"
		elif (action.axis==1 and action.axis_value<STATIC_AXIS_VALUE):
			return name_controller+" "+"UP IN LEFT AXIS"
		elif (action.axis==1 and action.axis_value>STATIC_AXIS_VALUE):
			return name_controller+" "+"DOWN IN LEFT AXIS"
		elif (action.axis==0 and action.axis_value<STATIC_AXIS_VALUE):
			return name_controller+" "+"LEFT IN LEFT AXIS"
		elif (action.axis==0 and action.axis_value>STATIC_AXIS_VALUE):
			return name_controller+" "+"RIGHT IN LEFT AXIS"
		elif (action.axis==6 and action.axis_value==1):
			return name_controller+" "+"L1"
		elif (action.axis==7 and action.axis_value==1):
			return name_controller+" "+"R1"
	elif (action is InputEventKey):
		return action.as_text()
	else:
		return name_controller+" "+"UNABLE INPUT. TRY AGAIN."




func display_keys():
	actions_list.get_node("Up/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(InputMap.get_action_list("g_up")[0])
	actions_list.get_node("Down/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(InputMap.get_action_list("g_down")[0])
	actions_list.get_node("Right/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(InputMap.get_action_list("g_right")[0])
	actions_list.get_node("Left/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(InputMap.get_action_list("g_left")[0])
	actions_list.get_node("Nitro/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(InputMap.get_action_list("g_nitro")[0])
	actions_list.get_node("Brake/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(InputMap.get_action_list("g_brake")[0])
	#return text


func set_flags_buttons_false():
	b_up = false
	b_down = false
	b_right = false
	b_left = false
	b_nitro = false
	b_brake = false



func _unhandled_input(event):
	if (event.is_pressed()==true 
	and (event is InputEventKey or (event is InputEventJoypadButton or event is InputEventJoypadMotion))):
		if (b_up):
			#print("UNHANDLED=",event.as_text())
			InputMap.action_erase_events("g_up")
			InputMap.action_add_event("g_up",event)
			actions_list.get_node("Up/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(event.as_text())
			actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_NONE
			actions_list.get_node("Up").grab_focus()
			b_up=false
		elif (b_down):
			InputMap.action_erase_events("g_down")
			InputMap.action_add_event("g_down",event)
			actions_list.get_node("Down/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(event.as_text())
			actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_NONE
			actions_list.get_node("Down").grab_focus()
			b_down=false
		elif (b_right):
			InputMap.action_erase_events("g_right")
			InputMap.action_add_event("g_right",event)
			actions_list.get_node("Right/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(event.as_text())
			actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_NONE
			actions_list.get_node("Right").grab_focus()
			b_right=false
		elif (b_left):
			InputMap.action_erase_events("g_left")
			InputMap.action_add_event("g_left",event)
			actions_list.get_node("Left/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(event.as_text())
			actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_NONE
			actions_list.get_node("Left").grab_focus()
			b_left=false
		elif (b_nitro):
			InputMap.action_erase_events("g_nitro")
			InputMap.action_add_event("g_nitro",event)
			actions_list.get_node("Nitro/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(event.as_text())
			actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_NONE
			actions_list.get_node("Nitro").grab_focus()
			b_nitro=false
		elif (b_brake):
			InputMap.action_erase_events("g_brake")
			InputMap.action_add_event("g_brake",event)
			actions_list.get_node("Brake/HBoxContainer/LabelInput").text = "%s" % convert_actions2bnames(event.as_text())
			actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_NONE
			actions_list.get_node("Brake").grab_focus()
			b_brake=false
		set_process_unhandled_input(false)
		display_keys()
	
	print("Saving keymap...")
	res_settings.act_buttons[0] = InputMap.get_action_list("g_up")
	res_settings.act_buttons[1] = InputMap.get_action_list("g_down")
	res_settings.act_buttons[2] = InputMap.get_action_list("g_right")
	res_settings.act_buttons[3] = InputMap.get_action_list("g_left")
	res_settings.act_buttons[4] = InputMap.get_action_list("g_nitro")
	res_settings.act_buttons[5] = InputMap.get_action_list("g_brake")
	ResourceSaver.save("res://resources/game_settings/game_settings.tres", res_settings)


func _on_Button_pressed():
	#get_tree().change_scene("res://scenes/main_menu/main_menu.scn")
	get_tree().change_scene("res://scenes/main_menu/main_menu.scn")


func _on_Up_pressed():
	if (b_up==false):
		#print("PRESSED")
		actions_list.get_node("Up/HBoxContainer/LabelInput").text = "..."
		b_up = true
		set_process_unhandled_input(true)
		actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_ALL
		actions_list.get_parent().get_parent().grab_focus()


func _on_Down_pressed():
	if (b_down==false):
		actions_list.get_node("Down/HBoxContainer/LabelInput").text = "..."
		b_down = true
		set_process_unhandled_input(true)
		actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_ALL
		actions_list.get_parent().get_parent().grab_focus()


func _on_Right_pressed():
	if (b_right==false):
		actions_list.get_node("Right/HBoxContainer/LabelInput").text = "..."
		b_right = true
		set_process_unhandled_input(true)
		actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_ALL
		actions_list.get_parent().get_parent().grab_focus()


func _on_Left_pressed():
	if (b_left==false):
		actions_list.get_node("Left/HBoxContainer/LabelInput").text = "..."
		b_left = true
		set_process_unhandled_input(true)
		actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_ALL
		actions_list.get_parent().get_parent().grab_focus()


func _on_Nitro_pressed():
	if (b_nitro==false):
		actions_list.get_node("Nitro/HBoxContainer/LabelInput").text = "..."
		b_nitro = true
		set_process_unhandled_input(true)
		actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_ALL
		actions_list.get_parent().get_parent().grab_focus()


func _on_Brake_pressed():
	if (b_brake==false):
		actions_list.get_node("Brake/HBoxContainer/LabelInput").text = "..."
		b_brake = true
		set_process_unhandled_input(true)
		actions_list.get_parent().get_parent().focus_mode=Control.FOCUS_ALL
		actions_list.get_parent().get_parent().grab_focus()


