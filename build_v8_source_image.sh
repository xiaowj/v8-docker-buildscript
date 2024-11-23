docker pull $IMAGE_NAME
if test $? -eq 0
then
    echo "found image $IMAGE_NAME"
else
    echo "not found image $IMAGE_NAME"
    docker build . --file Dockerfile --tag $IMAGE_NAME
    docker push $IMAGE_NAME
fi
