package main
# Deny if using 'latest' tag
deny[msg] {
    some i
    input[i].Cmd == "from"
    contains(input[i].Value[0], ":latest")
    msg := sprintf("Avoid using 'latest' tag in FROM instruction. Found: %s", [input[i].Value[0]])
}

# Deny if using ADD instruction
deny[msg] {
    some i
    input[i].Cmd == "add"
    msg := "Avoid using ADD instruction. Use COPY instead for better transparency."
}

# Deny if container runs as root user
deny[msg] {
    some i
    input[i].Cmd == "user"
    input[i].Value[0] == "root"
    msg := "Container should not run as root user. Use a non-root user with USER directive."
}

# Deny if missing HEALTHCHECK instruction
deny[msg] {
    not has_healthcheck
    msg := "Container must include HEALTHCHECK instruction"
}

has_healthcheck {
    some i
    input[i].Cmd == "healthcheck"
}




