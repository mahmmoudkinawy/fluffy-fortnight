FROM rust:1.76-slim as builder

# Set up dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev pkg-config curl git clang cmake build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

RUN cargo install ocrs-cli --locked

FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    libssl1.1 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/cargo/bin/ocrs-cli /usr/local/bin/ocrs-cli

ENTRYPOINT ["ocrs-cli"]
