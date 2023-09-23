.PHONY = templates bootstrap clean helm-plugins

CLUSTER ?= localhost

templates: clean
	for helmfile in apps/*/helmfile.yaml; do \
		helmfile.d/helper.sh $(CLUSTER); \
	done

	@DIFF=$$(git diff --name-only templated/$(CLUSTER)/ 2>/dev/null | true); \
	if [ -n "$$DIFF" ]; then \
		git add templated/$(CLUSTER)/*; \
		git commit -m "[CI] CLUSTER=$(CLUSTER) make templates"; \
	fi


bootstrap: templates
	helmfile sync -e $(CLUSTER) --selector app=argocd

clean:
	rm -rf templated/$(CLUSTER)/

helm-plugins:
	helm plugin install https://github.com/databus23/helm-diff --version v3.8.1
