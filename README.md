# Deamonset to install Gvisor on k8s cluster

This daemonset works on microk8s clusters alone; the containerd-template.toml is pre-loaded on the container used by the daemonset. 

Create an image for the daemonset
```
docker build --platform linux/amd64 -t yourregistry/gvisords:0.0.1 .
docker push yourregistry/gvisords:0.0.1
```
Deploy the daemonset
```
kubectl apply -f daemonSet.yaml
```
This will install the Gvisor version defined in the daemonSet.yaml file argument ( refer to https://github.com/google/gvisor/tags for release date reference )

Apply the runtime class
```
kubectl apply -f runtimeClass.yaml
```
Test the runtime with a pod running on the Gvsio created class
```
kubectl apply -f testDeployment.yaml
```

