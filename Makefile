.PHONY = templates sync delete clean helm-plugins

ENV ?= localhost

templates:
	for helmfile in apps/*/helmfile.yaml; do \
		helmfile.d/helper.sh $(ENV) \
		git add templated/$(ENV)/* \
		git commit -m "[CI] make templates $(ENV)"; \
	done

bootstrap:
	helmfile sync -e $(ENV) --selector app=argocd

clean:
	rm -rf templated/$(ENV)/

helm-plugins:
	helm plugin install https://github.com/databus23/helm-diff --version v3.8.1
