# Kubectl
# def "nu-complete kubectl" [] {
#     ^kubectl | lines | find "  " | str trim | parse "{command} {help}" | str trim | where command != "kubectl" | get command
# }

# Logs
def "nu-complete kubectl logs" [] {
    ^kubectl get po,deployment,job -o name | lines | str trim
}

# Services
def "nu-complete kubectl get svc" [] {
    nu-complete kubectl get-resource svc
}


def "nu-complete kubectl get-resource" [resource: string] {
    ^kubectl get $resource -o name | lines | skip 1 | split column "/" | get column2 | str trim
}


# Kubectl
# export extern "kubectl" [
#   command?: string@"nu-complete kubectl"
# ]

# Get
# export extern "kubectl get" [
#     resource?: string@"nu-complete kubectl get" # Target resource
#     name?: string@"nu-complete kubectl get-resource" # Target name
# ]

export extern "kubectl get svc" [
    name?: string@"nu-complete kubectl get svc" # Target service
    --output(-o): string #  Output format. One of:
    # json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-as-json|jsonpath-file|custom-columns-file|custom-columns|wide
    # See custom columns [https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns], golang template
    # [http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template
    # [https://kubernetes.io/docs/reference/kubectl/jsonpath/].
]

# Logs
export extern "kubectl logs" [
    target?: string@"nu-complete kubectl logs" # Target
    --container(-c): string # Print the logs of this container
    --follow(-f): bool #  Specify if the logs should be streamed.
    --ignore-errors: bool # If watching / following pod logs, allow for any errors that occur to be non-fatal
    --insecure-skip-tls-verify-backend: bool # Skip verifying the identity of the kubelet that logs are requested from.
    # In theory, an attacker could provide invalid log content back. You might want to use this if your kubelet serving
    # certificates have expired.

    --limit-bytes: int # Maximum bytes of logs to return. Defaults to no limit.
    --max-log-requests: int # Maximum bytes of logs to return. Defaults to no limit.
    --pod-running-timeout: string # The length of time (like 5s, 2m, or 3h, higher than zero) to wait until at least one
    # pod is running

    --prefix: bool # Prefix each log line with the log source (pod name and container name)
    --previous(-p): bool #  If true, print the logs for the previous instance of the container in a pod if it exists.
    --selector(-l): string # Selector (label query) to filter on.
    --since: string # Only return logs newer than a relative duration like 5s, 2m, or 3h. Defaults to all logs. Only one of
    # since-time / since may be used.

    --since-time: string # Only return logs after a specific date (RFC3339). Defaults to all logs. Only one of since-time /
    # since may be used.

    --tail: int #  Lines of recent log file to display. Defaults to -1 with no selector, showing all log lines otherwise
    # 10, if a selector is provided.

    --timestamps: bool # Include timestamps on each line in the log output
]
