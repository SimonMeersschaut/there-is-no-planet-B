extends CharacterBody2D

enum STATES {
	PARKED,
	FLYING
}

@export var state = STATES.PARKED
@export var thrust = 1000
@export var rotation_speed = 1

const R1 = 400
const R2 = 1000
const OMEGA = .2
const TAKEOFFSPEED = .4
const T1 = (R2-R1)/TAKEOFFSPEED

var height = 0
var t = 0

func _physics_process(delta):
	# Move spaceship
	t += delta
	if self.state == STATES.PARKED:
		position = Vector2.UP * R1
	else:
		var alpha = self.OMEGA * t
		
		# calculate distance
		var distance = R1
		if alpha < PI/2:
			# take off
			distance = atan(alpha) * (R2-R1) + R1
		elif alpha > PI/2 and alpha < 3*PI/2:
			# Mining
			distance = R2
		elif alpha < 2*PI:
			# Landing
			distance = atan(PI*3/2 - alpha) * (R2-R1) + R2
		else:
			# landed
			self.state = STATES.PARKED
		position = Vector2.UP.rotated(alpha) * distance
		#rotation = alpha + PI/2
