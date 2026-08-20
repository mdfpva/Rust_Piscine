MEMBERS := $(shell find day* -maxdepth 2 -name "Cargo.toml" 2>/dev/null | sed 's/\/Cargo.toml//')

all: workspace
	cargo build

clean:
	cargo clean
	rm -rf target/
	rm -rf day*/ex*/target/
	rm -f day*/ex*/Cargo.lock

test:
	cargo test

workspace:
	@echo "[workspace]" > Cargo.toml
	@echo "members = [" >> Cargo.toml
	@for member in $(MEMBERS); do \
		echo "    \"$$member\"," >> Cargo.toml; \
	done
	@echo "]" >> Cargo.toml
	@echo "resolver = \"3\"" >> Cargo.toml

.PHONY: all clean test workspace

