# Passes: Uses specific version tag
FROM alpine:3.19

# Passes: Sets non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Passes: Uses COPY instead of ADD
COPY ./local-file.txt /app/

# Passes: HEALTHCHECK directive
HEALTHCHECK CMD curl --fail http://localhost:5000/ || exit 1

# Install dependencies safely
RUN apk add --no-cache curl

CMD ["sh"]