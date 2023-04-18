tag="v0.0.1"

docker buildx build --platform linux/amd64 --rm -f "Dockerfile" -t tgoelles/sicopolis_base:$tag "."
docker run -it tgoelles/sicopolis_base:$tag