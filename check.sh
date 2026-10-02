#!/bin/sh
# Smoke check for calculator.py: pipes canned input into the program and
# checks the printed answer and the exit status. Run with: sh check.sh
#
# Each case supplies four input lines (first number, second number, operation,
# and the Enter that dismisses the exit prompt). The cases record what the
# program does today, including the divide remainder tracked in #8.

cd "$(dirname "$0")" || exit 1

py=""
for candidate in python2 python; do
	if command -v "$candidate" >/dev/null 2>&1 &&
		"$candidate" -c 'import sys; sys.exit(sys.version_info[0] != 2)' 2>/dev/null; then
		py="$candidate"
		break
	fi
done
if [ -z "$py" ]; then
	echo "SKIP: no Python 2 interpreter"
	exit 0
fi

failures=0

# check <name> <input> <expected substring> <expected exit status>
check() {
	output=$(printf '%b' "$2" | timeout 10 "$py" calculator.py 2>&1)
	status=$?
	if [ "$status" -ne "$4" ]; then
		echo "FAIL: $1 (exit $status, expected $4)"
		echo "$output"
		failures=$((failures + 1))
	elif ! printf '%s\n' "$output" | grep -qF -- "$3"; then
		echo "FAIL: $1 (expected: $3)"
		echo "$output"
		failures=$((failures + 1))
	else
		echo "PASS: $1"
	fi
}

check "add"                "6\n3\nadd\n\n"        "The answer is  9.0" 0
check "subtract"           "6\n3\nsubtract\n\n"   "The answer is  3.0" 0
# The legacy spelling Subract is still accepted.
check "subract"            "6\n3\nsubract\n\n"    "The answer is  3.0" 0
check "multiply"           "6\n3\nmultiply\n\n"   "The answer is  18.0" 0
check "divide"             "7\n2\ndivide\n\n"     "The answer is  3.5  with  1.0  left over." 0
check "mixed case, spaces" "6\n3\n  aDd \n\n"     "The answer is  9.0" 0
check "unknown operation"  "6\n3\nbanana\n\n"     "That wasn't an option." 0
check "divide by zero"     "6\n0\ndivide\n\n"     "The second number can't be zero." 0
# A number that isn't a number skips the remaining prompts, so only two lines
# are read: the bad number and the Enter at the exit prompt.
check "not a number"       "abc\n\n"              "That wasn't a number." 0

if [ "$failures" -ne 0 ]; then
	echo "$failures case(s) failed"
	exit 1
fi
echo "All cases passed"
