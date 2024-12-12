.PHONY: docker
docker:
	docker build . -t registry.cn-beijing.aliyuncs.com/obser/coroot-cluster-agent:latest
