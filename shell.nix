let
nixpkgs = import <nixpkgs> { };

  targetRuby = nixpkgs.ruby_3_2;

  myBundler = nixpkgs.bundler.override {
    ruby = targetRuby;
  };

  gems =
    nixpkgs.bundlerEnv {
      inherit (nixpkgs) ruby_3_2;

      name     = "rails-gems";
      bundler  = myBundler;
      gemfile  = ./Gemfile;
      lockfile = ./Gemfile.lock;
      gemset   = ./gemset.nix;
    };

in
  nixpkgs.mkShell {
    buildInputs = [
      targetRuby
      gems
      gems.wrappedRuby
      nixpkgs.bundler
      nixpkgs.bundix
      nixpkgs.jekyll
    ];
  }
