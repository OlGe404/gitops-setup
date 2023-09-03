.PHONY = helmfile-template

ENV ?= localhost

helmfile-template:
	helmfile template -e $(ENV) --include-crds \
	--output-dir-template "{{ .OutputDir }}/{{ .Release.Name }}" \
	--output-dir $(PWD)/templated/$(ENV)

bootstrap:
	helmfile sync -e $(ENV)

delete:
	helmfile delete -e $(ENV)
