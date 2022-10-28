FROM hexpm/elixir:1.13.2-erlang-25.1.2-ubuntu-jammy-20220428 as builder
ARG _MIX_ENV
ARG _RELEASE_NAME
RUN apt-get update
RUN apt-get install cmake -y
WORKDIR /src
COPY . .
RUN mix local.rebar --force
RUN mix local.hex --force
RUN mix deps.get
RUN MIX_ENV=${_MIX_ENV} mix release ${_RELEASE_NAME}
RUN mv _build/${_MIX_ENV}/rel/${_RELEASE_NAME} /opt/release
RUN mv /opt/release/bin/${_RELEASE_NAME} /opt/release/bin/app

FROM ubuntu:jammy-20220428 as runner
WORKDIR /opt/release
COPY --from=builder /opt/release .
CMD /opt/release/bin/app start