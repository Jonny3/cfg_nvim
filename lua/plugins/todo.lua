return {
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
		keys = {
			{ "<leader>st", "<cmd>TodoTelescope keywords=TODO,FIX<cr>", desc = "[S]earch ToDo only" },
			{ "<leader>sT", "<cmd>TodoTelescope<cr>", desc = "[S]earch ToDos" },
		},
	},
}
