# Violation 1: Uses 'latest' tag
FROM alpine:latest

# Violation 2: Runs as root (default)
USER root

# Violation 3: No HEALTHCHECK directive

# Violation 4: Uses ADD instruction
ADD https://example.com/file.tar.gz /tmp/

RUN apk add --no-cache curl

CMD ["sh"]