extends KURO_Effect
class_name EffectLoginToServer

@export var username: String
@export var password: String
@export var server_ip: String
@export var logout: bool

func apply():
	if server_ip != "": Resources.server_ip = server_ip
	Resources.username = username
	Resources.password = password
	var rq = EffectSendToServer.new()
	self.add_child(rq)

	# REQUEST
	if logout: rq.method = HTTPClient.Method.METHOD_DELETE
	else: rq.method = HTTPClient.Method.METHOD_POST
	rq.endpoint = "/api/users/%s/authenticate" % [username]
	rq.body = JSON.stringify({
		"username": username,
		"plaintext_password": password
	})
	await rq.apply()

	# RESPONCE
	var responce = rq.responce.body_json()
	if responce == null:
		push_error("failed to authenticate")
		return

	var token = responce.get("token")
	if token == null:
		push_error("server did not respond with valid token")
		return

	Resources.APIBearerToken = token
