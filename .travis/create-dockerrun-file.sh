#!/usr/bin/env bash
function get_tag {
  echo `cd ./projects/$1 && node -p "require('./package.json').version"`
}

cat << EOF > Dockerrun.aws.json
{
  "AWSEBDockerrunVersion": 2,
  "containerDefinitions": [
    {
      "name": "cop-watch-portal",
      "image": "$DOCKER_USERNAME/cop-watch-portal:$(get_tag cop-watch-portal)",
      "essential": true,
      "memory": 128,
      "portMappings": [
        {
          "hostPort": 80,
          "containerPort": 80
        }
      ]
    }
  ]
}
EOF

zip $BEANSTALK_ZIP_FILENAME Dockerrun.aws.json
