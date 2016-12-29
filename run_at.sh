NAME=powerslim

docker rm -f $NAME
docker run -d \
    -v $(pwd):/PowerSlim \
    --name=$NAME \
    -p 8082:8081 \
    -w /PowerSlim \
   mikeplavsky/powerslim 
