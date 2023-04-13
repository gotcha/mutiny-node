pack:
    wasm-pack build ./mutiny-wasm --dev --target web --scope mutinywallet

link:
    wasm-pack build ./mutiny-wasm --dev --target web --scope mutinywallet && cd mutiny-wasm/pkg && npm link

login:
    wasm-pack login --scope=@mutinywallet

release:
    wasm-pack build ./mutiny-wasm --release --target web --scope mutinywallet

publish:
    wasm-pack publish --access public -t web

test:
    wasm-pack test --headless --chrome ./mutiny-core
    wasm-pack test --headless --chrome ./mutiny-wasm

clippy:
    cargo clippy --package mutiny-core -- -Aclippy::drop_non_drop
    cargo clippy --package mutiny-wasm -- -Aclippy::drop_non_drop
