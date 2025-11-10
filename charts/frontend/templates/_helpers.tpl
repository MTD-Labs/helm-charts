{{- define "trendex-base-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "trendex-base-helm.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "trendex-base-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "trendex-base-helm.labels" -}}
helm.sh/chart: {{ include "trendex-base-helm.chart" . }}
{{ include "trendex-base-helm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "trendex-base-helm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "trendex-base-helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "trendex-base-helm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "trendex-base-helm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "trendex-base-helm.capabilities.kubeVersion" -}}
{{- default .Capabilities.KubeVersion.Version .Values.kubeVersion -}}
{{- end -}}
