pack:
    wasm-pack build ./mutiny-wasm --dev --target web --scope mutinywallet

link:
    wasm-pack build ./mutiny-wasm --dev --target web --scope mutinywallet && cd mutiny-wasm/pkg && pnpm link --global

login:
    wasm-pack login --scope=@mutinywallet

release:
    wasm-pack build ./mutiny-wasm --release --target web --scope mutinywallet

publish:
    wasm-pack publish --access public -t web

[macos]
test:
    cargo test -p mutiny-core --target=aarch64-apple-darwin
    WASM_BINDGEN_TEST_TIMEOUT=120 wasm-pack test --headless --chrome ./mutiny-core
    WASM_BINDGEN_TEST_TIMEOUT=120 wasm-pack test --headless --chrome ./mutiny-wasm

[linux]
test:
    cargo test -p mutiny-core --target=x86_64-unknown-linux-gnu
    WASM_BINDGEN_TEST_TIMEOUT=120 wasm-pack test --headless --chrome ./mutiny-core
    WASM_BINDGEN_TEST_TIMEOUT=120 wasm-pack test --headless --chrome ./mutiny-wasm

[macos]
clippy:
    cargo clippy --all-features --tests --package mutiny-core --target=wasm32-unknown-unknown -- -D warnings
    cargo clippy --all-features --tests --package mutiny-core --target=aarch64-apple-darwin -- -D warnings
    cargo clippy --all-features --tests --package mutiny-wasm -- -D warnings

[linux]
clippy:
    cargo clippy --all-features --tests --package mutiny-core --target=wasm32-unknown-unknown -- -D warnings
    cargo clippy --all-features --tests --package mutiny-core --target=x86_64-unknown-linux-gnu -- -D warnings
    cargo clippy --all-features --tests --package mutiny-wasm -- -D warnings
