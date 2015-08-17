module Request
	module JsonHelpers
		def json_response
			@json_response ||= JSON.parse(response.body, symbolize_names: true)
		end
	end
	module HeaderHelpers
		def api_header(version = 1)
			request.headers['Accept'] = "application/vnd.deadlines.v#{version}"
		end
		def api_respons_format = (Mime::JSON)
			request.headers['Accept'] = "#{reques.headers[Accept]},#{format}"
			request.headers[Content-Type] = format.to_s
		end
		def incude_default_accept_headers
			api_header
			api_respons_format
		end
	end
end