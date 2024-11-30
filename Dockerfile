FROM golang:1 AS build
COPY . /workspace
WORKDIR /workspace
RUN make build

FROM debian:stable-slim
COPY --from=build /workspace/bin /bin
CMD [ "/bin/cartographers" ]
