## Deployment template
- Different components will use different part of a `Deployment manifest`.
  Optional part of the `Deployment manifest` that are optional for the use by the components:
- Arguments given to the `pod` when it starts up.
- Environment variables
- Environment variables from `Secrets`
- Liveness probe
- Readiness probe
- ConfigMaps and the corresponding volumes

`_deployment.yaml`<br>
// first part, same as the service template
```yaml
{{- define "common.deployment" -}}
  {{- $common := dict "Values" .Values.common -}}
  {{- $noCommon := omit .Values "common" -}}
  {{- $overrides := dict "Values" $noCommon -}}
  {{- $noValues := omit . "Values" -}}
  {{- with merge $noValues $overrides $common -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "common.fullname" . }}
  labels:
    app.kubernetes.io/name: {{ include "common.name" . }}
    helm.sh/chart: {{ include "common.chart" . }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
```
// second part
```yaml
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app.kubernetes.io/name: {{ include "common.name" . }}
  template:
    metadata:
      labels:
        app.kubernetes.io/name: {{ include "common.name" . }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}/{{ .Values.image.name }}:{{ .Values.image.tag }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
```
//optional part
```yaml
args:
  {{- toYaml . | nindent 12 }}
  {{- end }}
  {{- if .Values.env }}
env:
  {{- range $key, $val := .Values.env }}
  - name: {{ $key }}
    value: {{ $val }}
  {{- end }}
  {{- end }}
  {{- if .Values.envFromSecretRefs }}
envFrom:
  {{- range .Values.envFromSecretRefs }}
  - secretRef:
      name: {{ . }}
  {{- end }}
  {{- end }}
  {{- if .Values.livenessProbe_enabled }}
livenessProbe:
  {{ toYaml .Values.livenessProbe | indent 12 }}
  {{- end }}
  {{- if .Values.readinessProbe_enabled }}
readinessProbe:
  {{ toYaml .Values.readinessProbe | indent 12 }}
  {{- end }}
```
//final part
```yaml
ports:
  {{ toYaml .Values.ports | indent 12 }}
resources:
  {{ toYaml .Values.resources | indent 12 }}
{{- if .Values.configmap.enabled }}
volumeMounts:
  - name: {{ include "common.fullname" . }}
    mountPath: {{ .Values.configmap.volumeMounts.mountPath }}
volumes:
  - name: {{ include "common.fullname" . }}
    configMap:
      name: {{ include "common.fullname" . }}
{{- end }}
```
// `common values.yaml`
Definition for the probes
```yaml
livenessProbe_enabled: false
livenessProbe:
  httpGet:
    scheme: HTTP
    path: /actuator/health/liveness
    port: 80
  initialDelaySeconds: 10
  periodSeconds: 10
  timeoutSeconds: 2
  failureThreshold: 20
  successThreshold: 1
readinessProbe_enabled: false
readinessProbe:
  httpGet:
    scheme: HTTP
    path: /actuator/health/readiness
    port: 80
  initialDelaySeconds: 10
  periodSeconds: 10
  timeoutSeconds: 2
  failureThreshold: 3
  successThreshold: 1
```
- Probes are disabled by default.
- Probes are based on http get requests to the spring actuator endpoints.