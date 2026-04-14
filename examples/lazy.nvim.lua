return {
	"vlicecream/UTreeSitter",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

		parser_config.unrealcpp = {
			install_info = {
				url = "https://github.com/vlicecream/UTreeSitter",
				files = { "src/parser.c", "src/scanner.c" },
				generate_requires_npm = false,
				requires_generate_from_grammar = false,
			},
			filetype = "unrealcpp",
		}

		local function is_unreal_project(path)
			local markers = vim.fs.find(function(name)
				return name:match("%.uproject$") or name:match("%.uplugin$")
			end, {
				path = vim.fs.dirname(path),
				upward = true,
				type = "file",
				limit = 1,
			})
			return #markers > 0
		end

		vim.filetype.add({
			extension = {
				cpp = function(path)
					if is_unreal_project(path) then
						return "unrealcpp"
					end
				end,
				h = function(path)
					if is_unreal_project(path) then
						return "unrealcpp"
					end
				end,
				hpp = function(path)
					if is_unreal_project(path) then
						return "unrealcpp"
					end
				end,
				hh = function(path)
					if is_unreal_project(path) then
						return "unrealcpp"
					end
				end,
				cc = function(path)
					if is_unreal_project(path) then
						return "unrealcpp"
					end
				end,
				cxx = function(path)
					if is_unreal_project(path) then
						return "unrealcpp"
					end
				end,
				inl = function(path)
					if is_unreal_project(path) then
						return "unrealcpp"
					end
				end,
			},
		})
	end,
}
