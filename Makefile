.PHONY = templates sync delete clean helm-plugins

ENV ?= localhost

templates:
	for helmfile in apps/*/helmfile.yaml; do \
		helmfile.d/helper.sh $(ENV); \
	done

sync:
	helmfile sync -e $(ENV)

delete:
	helmfile delete -e $(ENV)

clean:
	rm -rf templated/$(ENV)/

helm-plugins:
	helm plugin install https://github.com/databus23/helm-diff --version v3.8.1
