# Nixvim Configurations

{
	description = "Flake for my nixvim config, a distro of neovim using nixs declarativity";
	inputs = {
		nixvim.url = "github:pta2002/nixvim";
	};

	outputs = {self, nixpkgs, nixvim, ... }:
	{
		programs.nixvim = {
			enable = true;
			plugins = {
				start = {
					telescope = {
						plugin = { repo = "nvim-telescop.nvim"; };
					};
					treesitter = {
						plugin = { repo = "nvim-treesitter/nvim-treesitter"; };
					};
				};
			};
			settings = {
				vim.o.number = true;
				vim.o.relativenumber = true;
				vim.o.tabstop = 2;
				vim.o.shiftwidth = 4;
				vim.o.expandtab = true;
			};
		};
	};
}

