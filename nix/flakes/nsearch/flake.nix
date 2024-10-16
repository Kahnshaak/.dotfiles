{
	description = "Search package I liked from niksingh710";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nsearch = {
			url = "github:niksingh710/nsearch";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	outputs = { nixpkgs, nsearch, ... }:
	{
		

}
