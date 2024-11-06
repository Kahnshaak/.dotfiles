{
	description = "Search package I liked from niksingh710";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nsearch.url = "github:niksingh710/nsearch";
	};
	outputs = { nixpkgs, nsearch, ... }:
	{
		devShells.default = nixpkgs.lib.mkShell {
			nativeBuildInputs = [
				nixpkgs.cmake
				nixpkgs.gcc
			];
			shellHook = ''
				echo "Enter a package to nsearch"
			'';

		};

		packages.default = nsearch.packages.default;
	};
}
