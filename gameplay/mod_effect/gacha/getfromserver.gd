extends KURO_Effect
class_name EffectGetFromServer

@export var endpoint: String

@export_category("touchy-is-not-really-useful stuff")
@export var session_token: String
@export var headers: PackedStringArray = PackedStringArray([
	"Content-Type: application/json",
	"Accept: application/json",
	#"User-Agent: GodotEngine/4.4.1",
])

var responce: HTTPResponce

func apply():
	headers.append("Authorization: Bearer %s" % Resources.APIBearerToken)
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
		HTTPClient.Method.METHOD_GET
	)
	
	await http.request_completed
	print("Goodbye, server!")
	http.queue_free()

func _on_request_completed(result, response_code, headers, body):
	if result != OK:
		push_error("Request failed! %s" % result)
	
	print()
	print()
	print("HTTP DATA SHOWN BELOW ")
	print("======================")
	print("result: %s            " %result)
	print("response_code: %s     " %response_code)
	print("headers: %s           " %headers)
	print("body: %s              " %body)
	print("=====================")
	print("HTTP DATA SHOWN ABOVE")
	print()
	print()
	responce = HTTPResponce.new()
	responce.result = result
	responce.code = response_code
	responce.headers = headers
	responce.body = body

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
