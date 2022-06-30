{ system ? builtins.currentSystem
, config ? { }
, pkgs ? import ../../.. { inherit system config; }
}:

with pkgs.lib;

foldl
  (matrix: ver: matrix // {
    "basic${toString ver}" = import ./basic.nix { inherit system pkgs; nextcloudVersion = ver; };
    "with-postgresql-and-redis${toString ver}" = import ./with-postgresql-and-redis.nix {
      inherit system pkgs;
      nextcloudVersion = ver;
    };
    "with-mysql-and-memcached${toString ver}" = import ./with-mysql-and-memcached.nix {
      inherit system pkgs;
      nextcloudVersion = ver;
    };
    "with-declarative-redis${toString ver}" = import ./with-declarative-redis.nix {
      inherit system pkgs;
      nextcloudVersion = ver;
    };
    "with-secrets${toString ver}" = import ./with-secrets.nix {
      inherit system pkgs;
      nextcloudVersion = ver;
    };
  })
{ }
  [ 23 24 ]
