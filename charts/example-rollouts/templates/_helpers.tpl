{{/*
Expand the name of the chart.
*/}}
{{- define "example-rollouts.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "example-rollouts.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "example-rollouts.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "example-rollouts.labels" -}}
helm.sh/chart: {{ include "example-rollouts.chart" . }}
{{ include "example-rollouts.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "example-rollouts.labels-preview" -}}
helm.sh/chart: {{ include "example-rollouts.chart" . }}
{{ include "example-rollouts.selectorLabels-preview" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "example-rollouts.selectorLabels" -}}
app.kubernetes.io/name: {{ include "example-rollouts.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "example-rollouts.selectorLabels-preview" -}}
app.kubernetes.io/name: "{{ include "example-rollouts.fullname" . }}-preview"
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "example-rollouts.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "example-rollouts.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
