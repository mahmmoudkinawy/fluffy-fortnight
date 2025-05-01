FROM rust:1.76-slim

RUN apt-get update && apt-get install -y \
    libssl-dev pkg-config curl git clang cmake build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

RUN cargo install ocrs-cli --locked

ENTRYPOINT ["ocrs-cli"]
