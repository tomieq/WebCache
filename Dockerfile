FROM swift:5.9 as builder
WORKDIR /app
COPY . .
RUN swift build -c release
# aarch64-unknown-linux-gnu for raspberry pi
# x86_64-unknown-linux-gnu for intel based architectures
RUN mkdir output
RUN cp -R $(swift build --show-bin-path -c release)/WebCache output/App

FROM swift:5.9-slim
WORKDIR /app
COPY --from=builder /app/output/App .
CMD ["./App"]
