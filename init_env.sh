TAG_NAME=$(grep 'RUN git checkout' Dockerfile | awk '{print $4}' | sed -e 's/\//-/g')
echo "TAG_NAME=${TAG_NAME}" >> $GITHUB_ENV
echo "IMAGE_NAME=archive94/v8-source-image:${TAG_NAME}" >> $GITHUB_ENV
cat $GITHUB_ENV