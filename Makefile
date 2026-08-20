MEMBERS := $(shell find day* -maxdepth 2 -name "Cargo.toml" 2>/dev/null | sed 's/\/Cargo.toml//')

# O fluxo ideal: gera o workspace, valida o estilo/linter, compila, testa e executa
all:
	clear
	$(MAKE) workspace fmt clippy build test run-all

build:
	cargo build

clean:
	cargo clean
	rm -rf target/
	rm -rf day*/ex*/target/
	rm -f day*/ex*/Cargo.lock

test:
	cargo test --workspace

workspace:
	@echo "[workspace]" > Cargo.toml
	@echo "members = [" >> Cargo.toml
	@for member in $(MEMBERS); do \
		echo "    \"$$member\"," >> Cargo.toml; \
	done
	@echo "]" >> Cargo.toml
	@echo "resolver = \"3\"" >> Cargo.toml

# Verifica se o código está devidamente formatado de acordo com o padrão do Rust e corrige
fmt:
	cargo fmt --all -- --check
	cargo fmt --all

# Executa o linter do Rust para detetar más práticas ou potenciais bugs
clippy:
	cargo clippy --workspace -- -D warnings

# Executa um exercício específico. Exemplo: make run ex=ex00
run: workspace
	@if [ -z "$(ex)" ]; then \
		echo "Erro: Especifica o exercício. Exemplo: make run ex=ex00"; \
		exit 1; \
	fi
	cargo run -p $(ex)

# Executa todos os exercícios de forma robusta, lendo o nome do pacote diretamente do manifesto
run-all: workspace
	@for member in $(MEMBERS); do \
		echo "=== Executando $$member ==="; \
		pkg_name=$$(cargo read-manifest --manifest-path $$member/Cargo.toml | tr '{}' '\n' | grep '"name"' | cut -d'"' -f4); \
		cargo run -p $$pkg_name; \
	done

.PHONY: all build clean test workspace fmt clippy run run-all

