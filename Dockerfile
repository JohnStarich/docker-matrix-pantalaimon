FROM matrixdotorg/pantalaimon:v0.9.2

COPY --from=johnstarich/env2config:v0.1.4 /env2config /
RUN mkdir -p /config
ENV E2C_CONFIGS=config

# Config reference: https://github.com/matrix-org/pantalaimon/blob/0.9.2/docs/man/pantalaimon.5.md
ENV CONFIG_OPTS_FILE=/config/pantalaimon.conf
ENV CONFIG_OPTS_FORMAT=ini
ENV CONFIG_Default.LogLevel=Debug
ENV CONFIG_Default.SSL=True
ENV CONFIG_OPTS_IN_local-matrix.Homeserver=MATRIX_URL
ENV CONFIG_local-matrix.ListenAddress=0.0.0.0
ENV CONFIG_local-matrix.ListenPort=8008
ENV CONFIG_local-matrix.SSL=False
ENV CONFIG_local-matrix.UseKeyring=False
ENV CONFIG_local-matrix.IgnoreVerification=True

ENTRYPOINT ["/env2config", "pantalaimon", "--config", "/config/pantalaimon.conf"]
