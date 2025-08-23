# Validating AWS SES credentials

I wanted a way to quickly check if credentials where valid for [AWS](../391) [SES](../1112) so I created a script.

I built it using GPT and the [docs][testing-docs]. See script below:

```bash
#!/usr/bin/env bash

declare NOCOLOR=
[[ -t 1 ]] || NOCOLOR=y
declare GOLD='[38;2;184;138;0m'
declare RED='[38;2;255;0;0m'
declare GREY='[38;2;100;100;100m'
declare CYAN='[38;2;0;255;255m'
declare GREEN='[38;2;0;255;0m'
declare RESET='[0m'

if [[ -n "$NOCOLOR" ]]; then
	GOLD=
	RED=
	GREY=
	CYAN=
	GREEN=
	RESET=
fi

USER=$1
PASS=$2
REGION=${3:-}

die() {
	local msg="$1"
	echo -e "${RED}ERROR:${RESET} $msg" >&2
	exit 1
}

info() {
	local msg="$1"
	echo -e "${GREEN}INFO:${RESET} $msg"
}

# Basic validation:
# - both USER and PASS must be provided
# - must not contain whitespace
# - enforce reasonable length bounds to catch obvious mistakes

if [[ -z "$USER" || -z "$PASS" ]]; then
	die "USER and PASS are required. Usage: $0 USER PASS [REGION]"
fi

if [[ "$USER" =~ [[:space:]] || "$PASS" =~ [[:space:]] ]]; then
	die "USER and PASS must not contain whitespace characters"
fi

# USER length: 4..128 (covering short test values and real keys)
user_len=${#USER}
if ((user_len < 4 || user_len > 128)); then
	die "USER length is $user_len; expected between 4 and 128 characters"
fi

# PASS length: at least 8, max 512
pass_len=${#PASS}
if ((pass_len < 8 || pass_len > 512)); then
	die "PASS length is $pass_len; expected between 8 and 512 characters"
fi

# Default region if not supplied
if [[ -z "$REGION" ]]; then
	REGION="us-east-1"
	info "No region supplied, defaulting to $REGION"
fi

# Ensure required tools are present
if ! command -v openssl >/dev/null 2>&1; then
	die "openssl is required but not installed or not in PATH"
fi
if ! command -v base64 >/dev/null 2>&1; then
	die "base64 is required but not installed or not in PATH"
fi

ENDPOINT="email-smtp.${REGION}.amazonaws.com"
PORT=587

info "Performing a simple SMTP AUTH test against SES endpoint ${ENDPOINT}:${PORT} (will not print the password)."

# Build SMTP conversation: EHLO, AUTH LOGIN <base64 user> <base64 pass>, QUIT
b64_user=$(echo -n "$USER" | openssl enc -base64)
b64_pass=$(echo -n "$PASS" | openssl enc -base64)

smtp_payload="EHLO localhost
AUTH LOGIN
$b64_user
$b64_pass
QUIT"

OPENSSL_CMD=(openssl s_client -starttls smtp -quiet -crlf -connect "${ENDPOINT}:${PORT}")
RESP=$(printf "%s" "$smtp_payload" | "${OPENSSL_CMD[@]}" 2>/dev/null || true)

# Check for successful authentication. SES responds with 235 on success.
if printf "%s" "$RESP" | grep -qE "^235| 235 "; then
	info "SMTP authentication succeeded (credentials valid for SES SMTP endpoint)."
	# Return the USER value as originally intended.
	echo -n "$USER"
else
	# Extract relevant SMTP server response lines (codes and final messages) for diagnosis, avoid printing the password
	server_summary=$(printf "%s" "$RESP" | sed -n '1,200p' | sed -n '/^220/,/^QUIT/p' | tr -s '\r\n' '\n' | sed -n '1,20p')
	# Fallback: if server_summary empty, show some of the response for debugging (still safe: no passwords in server output)
	if [[ -z "$server_summary" ]]; then
		server_summary=$(printf "%s" "$RESP")
	fi
	die "SMTP authentication failed. Server response:\n$server_summary"
fi
```

[testing-docs]: https://docs.aws.amazon.com/ses/latest/dg/send-email-smtp-client-command-line.html

## Notes / considerations

- The hostname is arbitrary. Clients my use this for filtering and such
- Can't send emails from outside domains unless the email is validated in the SES admin
