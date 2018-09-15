import logging

function pkg_cargo_repos() {
    egrep -R "repository = .http" ~/.cargo/registry/ --include "*.toml" | grep -oP "(?<= .)http[^\"']+"
}

loaded pkg
