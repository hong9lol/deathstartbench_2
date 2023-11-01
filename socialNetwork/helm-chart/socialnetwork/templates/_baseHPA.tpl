{{- define "socialnetwork.templates.baseHPA" }}

apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: {{ .Values.name }}
  namespace: default
spec:
  maxReplicas: {{ .Values.maxReplicas | default .Values.global.hpa.maxReplicas }}
  minReplicas: {{ .Values.minReplicas | default .Values.global.hpa.minReplicas }}
  targetCPUUtilizationPercentage: 60
  scaleTargetRef:
    apiVersion: extensions/v1beta1
    kind: Deployment
    name: {{ .Values.name }}
{{- end }}