### Secret template
Is designed to create Secrets defined by values like credentials provided by the environments(ex. dev-env)<br>
The Secrets will be mapped as environment variables in the Pods<br>
The template is designed to create multiple Secret manifests using the range function in Helm.<br>
Ex. _secret.yaml
```yaml
{{- define "common.secrets" -}}
{{- range $secretName, $secretMap := .Values.secrets }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    app.kubernetes.io/name: {{ $secretName }}
    helm.sh/chart: {{ include "common.chart" $ }}
    app.kubernetes.io/managed-by: {{ $.Release.Service }}
type: Opaque
data:
{{- range $key, $val := $secretMap }}
  {{ $key }}: {{ $val | b64enc }}
{{- end }}
---
{{- end -}}
{{- end -}}
```
- `{{- define "common.secrets" -}}` declaration of the template.
- `{{- range $secretName, $secretMap := .Values.secrets }}` it iterates over the secrets defined in the `values.yaml` file.
- The function assumes that the field `.Values.secrets` contains a map of Secret names and a map of the Secret’s key/value pairs.
- Since the range function changes the current scope, we can no longer use the dot notation to pass the root context to the `common.chart` template.<br> Instead, the variable `$` has to be used.
- In the data section of the manifest, a second range function is applied a second time to traverse the current Secret’s key/value pairs.<br>
  Each key/value pair is assigned by the range function to the variables `$key` and `$val`.
- The Secret’s key/value pairs are defined as a map entry in the data section.<br>
  The value in the `$val` variable is piped to the b64enc function to get it properly Base64-encoded as required by a `Secret manifest`.
- The `---` is used to separate the rendered `Secret manifests` from each other so that they are processed as separate YAML documents.


A declaration of the Secrets field in one of the environment’s values.yaml files will look like this:
```yaml
secrets:
  a-secret:
    key-1: secret-value-1
    key-2: secret-value-2
  another-secret:
    key-3: secret-value-3
```
This definition will render two Secrets, named a-secret and another-secret.<br>
The range function assigns the current Secret name and its map to the variables `$secretName` and `$secretMap`.

to see the output:
```shell
for f in components/*; do helm dependency update $f; done
helm dependency update environments/dev-env
helm template environments/dev-env -s templates/secrets.yaml
```