extends KURO_Effect

enum Method {
	ENGINE,
	SAMPLES
}
@export var method: Method

func apply_engine():
	return Engine.get_frames_per_second()

var frame_times = []
@export var max_samples: int = 30  # number of frames to average over
func apply_samples(delta):
	# Track the delta times for last N frames
	frame_times.append(delta)
	if frame_times.size() > max_samples:
		frame_times.pop_front()
	
	# Calculate average FPS over those frames
	var avg_delta = 0.0
	for t in frame_times:
		avg_delta += t
	avg_delta /= frame_times.size()
	
	var fps = 1.0 / avg_delta if avg_delta > 0 else 0
	return fps

func apply():
	match method:
		Method.ENGINE:
			return apply_engine()
		Method.SAMPLES:
			return apply_samples(get_process_delta_time())
		_:
			Globals.crash("get_fps: Unknown FPS get method")
