### Service template

The Service template introduces support for overriding default values from the `common chart`, with values specific to the charts that use the common chart.<br>
Usually the common chart provides default values for the service type and what port will it be exposed on, but you can override these values through the `values.yaml` file of the chart of the specific microservice.<br>
Ex. _service.yaml
```yaml
{{- define "common.service" -}}
{{- $common := dict "Values" .Values.common -}}
{{- $noCommon := omit .Values "common" -}}
{{- $overrides := dict "Values" $noCommon -}}
{{- $noValues := omit . "Values" -}}
{{- with merge $noValues $overrides $common -}}
```
- values from the microservice values.yaml file will be available in the `.Values object`.
- the common chart’s values will be available under the field `.Values.common`.
- `{{- $common := dict "Values" .Values.common -}}` creates a new dictionary with the common chart’s values available under the key `.Values.common`.
- `{{- $noCommon := omit .Values "common" -}}` creates a new dictionary with all values from the microservice and without the common chart’s values.
- `{{- $overrides := dict "Values" $noCommon -}}` will refer to the `$noCommon` dictionary.
- `{{- $noValues := omit . "Values" -}}` will hold all other built-in objects, except for the Values object.
- `{{- with merge $noValues $overrides $common -}}` will merge the three dictionaries into one (`$noValues`, `$overrides`, `$common`).
- values found in the `$overrides` dictionary will take precedence over values in the `$common` dictionary, thereby overriding its values.

Ex. common chart’s values
```yaml
Service:
  type: ClusterIP
  ports:
    - port: 80
      targetPort: http
      protocol: TCP
      name: http
```
The gateway service needs to be a nodeport and use other port settings in order to do so :
override the above default values with chart’s values.yaml file
```yaml
service:
  type: NodePort
  ports:
    - port: 443
      targetPort: 8443
      nodePort: 30443
```

Ex. service template
```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "common.fullname" . }}
  labels:
    app.kubernetes.io/name: {{ include "common.name" . }}
    helm.sh/chart: {{ include "common.chart" . }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
spec:
  type: {{ .Values.service.type }}
  ports:
    {{ toYaml .Values.service.ports | indent 4 }}
  selector:
    app.kubernetes.io/name: {{ include "common.name" . }}
{{- end -}}
{{- end -}}
```

- `type` `{{ .Values.service.type }}` set the type of the service.
- `ports` `{{ toYaml .Values.service.ports | indent 4 }}` set the ports of the service.
- `selector` `{{ include "common.name" . }}` is used to select the Pods that the service will route traffic to.

to see the standard output:
```shell
helm dependency update components/product
helm template components/product -s templates/service.yaml
```
to see the output with the override values:
```shell
helm dependency update components/gateway
helm template components/gateway -s templates/service.yaml
```