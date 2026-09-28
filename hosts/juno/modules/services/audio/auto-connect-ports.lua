-- SHAMELESSLY STOLEN FROM https://github.com/bennetthardwick/dotfiles/blob/master/.config/wireplumber/scripts/auto-connect-ports.lua
-- As explained on: https://bennett.dev/auto-link-pipewire-ports-wireplumber/

-- Link two ports together
function link_port(output_port, input_port)
	if not input_port or not output_port then
		return nil
	end

	local link_args = {
		["link.input.node"] = input_port.properties["node.id"],
		["link.input.port"] = input_port.properties["object.id"],

		["link.output.node"] = output_port.properties["node.id"],
		["link.output.port"] = output_port.properties["object.id"],

		-- The node never got created if it didn't have this field set to something
		["object.id"] = nil,

		-- I was running into issues when I didn't have this set
		["object.linger"] = true,

		["node.description"] = "Link created by auto_connect_ports",
	}

	local link = Link("link-factory", link_args)
	link:activate(1)

	return link
end

-- Automatically link ports together by their specific audio channels.
--
-- ┌──────────────────┐         ┌───────────────────┐
-- │                  │         │                   │
-- │               FL ├────────►│ AUX0              │
-- │      OUTPUT      │         │                   │
-- │               FR ├────────►│ AUX1  INPUT       │
-- │                  │         │                   │
-- └──────────────────┘         │ AUX2              │
--                              │                   │
--                              └───────────────────┘
--
-- -- Call this method inside a script in global scope
--
-- auto_connect_ports {
--
--   -- A constraint for all the required ports of the output device
--   output = Constraint { "node.name"}
--
--   -- A constraint for all the required ports of the input device
--   input = Constraint { .. }
--
--   -- A mapping of output audio channels to input audio channels
--
--   connections = {
--     ["FL"] = "AUX0"
--     ["FR"] = "AUX1"
--   }
--
-- }
--
function auto_connect_node_to_port(args)
	print("find_port_from_node called")
	print(args)
	local node_om = ObjectManager({
		Interest({
			type = "node",
			args["node"],
			Constraint({ "media.class", "equals", "Audio/Source" }),
		}),
	})

	function _connect()
		print("_connect (node) called")
		for node in node_om:iterate() do
			print(node)
			for k, v in pairs(node.properties) do
				print("k: " .. k)
				print("v: " .. v)
			end
			-- return node.properties["object.path"]
			auto_connect_ports({
				output = Constraint({ "object.path", "matches", node.properties["object.path"] .. "*" }),
				input = args["input"],
				connect = args["connect"],
			})
			return
		end
	end

	node_om:connect("object-added", _connect)
	node_om:activate()
end

function auto_connect_ports(args)
	print("auto_connect_ports called")
	print(args)
	local output_om = ObjectManager({
		Interest({
			type = "port",
			args["output"],
			Constraint({ "port.direction", "equals", "out" }),
		}),
	})

	local links = {}

	local input_om = ObjectManager({
		Interest({
			type = "port",
			args["input"],
			Constraint({ "port.direction", "equals", "in" }),
		}),
	})

	local all_links = ObjectManager({
		Interest({
			type = "link",
		}),
	})

	local unless = nil

	if args["unless"] then
		unless = ObjectManager({
			Interest({
				type = "port",
				args["unless"],
				Constraint({ "port.direction", "equals", "in" }),
			}),
		})
	end

	function _connect()
		print("_connect called")
		local delete_links = unless and unless:get_n_objects() > 0

		if delete_links then
			print("delete_links then")
			for _i, link in pairs(links) do
				link:request_destroy()
			end

			links = {}

			return
		end

		for output_name, input_names in pairs(args.connect) do
			print("output_name = ")
			print(output_name)
			print("input_names = ")
			print(input_names)
			local input_names = input_names[1] == nil and { input_names } or input_names

			if delete_links then
				print("delete_links, skipping")
				goto dlContinue
			end
			-- Iterate through all the output ports with the correct channel name
			for output in output_om:iterate({ Constraint({ "audio.channel", "equals", output_name }) }) do
				print("output = ")
				print(output)
				for _i, input_name in pairs(input_names) do
					print("input_name = ")
					print(input_name)
					print("_i = ")
					print(_i)
					-- Iterate through all the input ports with the correct channel name
					for input in
						input_om:iterate({
							Constraint({ "audio.channel", "equals", input_name }),
						})
					do
						print("input = ")
						print(input)
						-- Link all the nodes
						local link = link_port(output, input)

						if link then
							table.insert(links, link)
						end
					end
				end
			end
			::dlContinue::
		end
	end

	output_om:connect("object-added", _connect)
	input_om:connect("object-added", _connect)
	all_links:connect("object-added", _connect)

	output_om:activate()
	input_om:activate()
	all_links:activate()

	if unless then
		unless:connect("object-added", _connect)
		unless:connect("object-removed", _connect)
		unless:activate()
	end
end

-- Connect Discord Audio -> DFN
auto_connect_ports({
	output = Constraint({ "object.path", "matches", "Discord Audio*" }),
	input = Constraint({ "object.path", "matches", "DeepFilterNet Input*" }),
	connect = {
		["FL"] = "FL",
		["FR"] = "FR",
	},
})

-- Connect DFN -> Compressor
auto_connect_ports({
	output = Constraint({ "object.path", "matches", "DeepFilterNet Output*" }),
	input = Constraint({ "object.path", "matches", "Compressor Input*" }),
	connect = {
		["FL"] = "FL",
		["FR"] = "FR",
	},
})

