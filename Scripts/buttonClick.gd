extends Button

@export var speed := 200000.0  # prędkość wydłużania
var is_extending := false

@onready var line = $PipeFill
@onready var button2 = $Button2

func _on_pressed():
	is_extending = true  # jedno kliknięcie uruchamia wydłużanie

func _process(delta):
	if is_extending:
		var pts = line.points
		
		# przelicz lewą krawędź Button2 w lokalnych współrzędnych Line2D
		var limit_x = line.to_local(button2.global_position).x - button2.get_size().x / 2
		
		# wydłużanie punktu w prawo
		pts[1].x += speed * delta
		
		# zatrzymanie przy lewej krawędzi Button2
		if pts[1].x >= limit_x:
			pts[1].x = limit_x
			is_extending = false
			self.disabled = true
			
			button2.modulate = Color(0,255,0)
			# Tworzymy nowy StyleBoxFlat dla stanu normal
			var stylebox = StyleBoxFlat.new()
			stylebox.bg_color = Color(0.3, 0.8, 0.3, 0.6)  # zielone tło

			# Podmieniamy tylko tło przycisku
			self.add_theme_stylebox_override("normal", stylebox)
			self.modulate = Color(0,255,0)
			
		line.points = pts
