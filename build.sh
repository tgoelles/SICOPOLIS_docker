tag="v0.0.1"

docker build --rm -f "Dockerfile" -t tgoelles/sicopolis_base:$tag "."
docker run -it tgoelles/sicopolis_base:$tag