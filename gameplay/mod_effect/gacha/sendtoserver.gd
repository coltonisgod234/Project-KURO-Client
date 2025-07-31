extends KURO_Effect
class_name EffectSendToServer

@export var endpoint: String
@export var body: String
@export var method: HTTPClient.Method = HTTPClient.Method.METHOD_POST
@export var enable_bearer: bool = true

@export_category("touchy-is-not-really-useful stuff")
@export var base_headers: PackedStringArray = PackedStringArray([
	"Content-Type: application/json",
	"Accept: application/json",
	#"User-Agent: GodotEngine/4.4.1",
])

var responce: HTTPResponce

func apply():
	# make additions to headers
	var headers
	if enable_bearer:
		headers = base_headers.duplicate()
		headers.append("Authorization: Bearer %s" % Resources.APIBearerToken)
	else:
		headers = base_headers

	push_error("S IP %s" % Resources.server_ip)
	var url: String = "%s%s" % [Resources.server_ip, endpoint]
	# =-- setup --=
	var http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_request_completed)
	
	# =-- make the request --=
	print("Hello, %s?" % url)
	http.request(
		url,
		headers,
		method,
		body
	)

	await http.request_completed
	print("Goodbye, server!")
	http.queue_free()

func _on_request_completed(result, response_code, headers, body_):
	if result != OK:
		push_error("Request failed! %s" % result)
	
	print()
	print()
	print("HTTP DATA SHOWN BELOW ")
	print("======================")
	print("result: %s            " %result)
	print("response_code: %s     " %response_code)
	print("headers: %s           " %headers)
	print("body: %s              " %body_)
	print("=====================")
	print("HTTP DATA SHOWN ABOVE")
	print()
	print()
	responce = HTTPResponce.new()
	responce.result = result
	responce.code = response_code
	responce.headers = headers
	responce.body = body_

class HTTPResponce:
	@export var result: int
	@export var code: int
	@export var headers: PackedStringArray
	@export var body: PackedByteArray
	func body_utf8():
		return body.get_string_from_utf8()

	func body_ascii():
		return body.get_string_from_ascii()

	func body_json():
		return JSON.parse_string(body.get_string_from_utf8())
