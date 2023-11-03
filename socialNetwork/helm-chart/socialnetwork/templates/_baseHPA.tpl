{{- define "socialnetwork.templates.baseHPA" }}

apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  annotations:
    "helm.sh/hook": "post-install"
  name: {{ .Values.name }}
  namespace: default
spec:
  maxReplicas: {{ .Values.maxReplicas | default .Values.global.hpa.maxReplicas }}
  minReplicas: {{ .Values.minReplicas | default .Values.global.hpa.minReplicas }}
  targetCPUUtilizationPercentage: {{ .Values.maxReplicas | default .Values.global.hpa.tcu }}
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ .Values.name }}
{{- end }}