.PHONY = templates bootstrap clean helm-plugins

ENV ?= localhost

templates: clean
	for helmfile in apps/*/helmfile.yaml; do \
		helmfile.d/helper.sh $(ENV); \
	done

bootstrap: templates
	helmfile sync -e $(ENV) --selector app=argocd

clean:
	rm -rf templated/$(ENV)/

helm-plugins:
	helm plugin install https://github.com/databus23/helm-diff --version v3.8.1
