### ConfigMap template
Is designed to create ConfigMaps from files in the folder config-repo.<br>
A `ConfigMap` will contain all non-sensitive configuration required by a specific `Deployment`.<br>
The `ConfigMap` will be mounted as a volume in the `Pod` that runs the `Deployment`.<br>
The `Pod` will read the configuration from the `ConfigMap` as files in its local filesystem.<br>
Ex. `_configmap_from_file.yaml`
```yaml
{{- define "common.configmap_from_file" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.fullname" . }}
  labels:
    app.kubernetes.io/name: {{ include "common.name" . }}
    helm.sh/chart: {{ include "common.chart" . }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
data:
  {{ (.Files.Glob "config-repo/*").AsConfig | indent 2 }}
{{- end -}}
```
explaination:
- `{{- define "common.configmap_from_file" -}}` is used to declare the name of the reusable template.
- `{{ include "common.fullname" . }}` it set the name of the ConfigMap through the file _helpers.tpl.
- `{{ include "common.name" . }}` mark that this Service has been created using Helm.
- `{{ .Release.Service }}` it always returns the value Helm.
- `{{ (.Files.Glob "config-repo/*").AsConfig | indent 2 }}` it reads all files in the folder config-repo and converts them to a YAML map with the right indentation(2 spaces).
- `{{- end -}}` is used to close the template.
  Ex.
```shell
cd /kubernetes/helm/components/config-server
helm dependency update .
helm template . -s templates/configmap_from_file.yaml
```
output:
```yaml
# Source: config-server/templates/configmap_from_file.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: config-server
  labels:
    app.kubernetes.io/name: config-server
    helm.sh/chart: config-server-1.0.0
    app.kubernetes.io/managed-by: Helm
data:
  application.yml: |-
    app:
      auth-server: localhost
    ...
  auth-server.yml: |-
    server.port: 9999
    ...
```