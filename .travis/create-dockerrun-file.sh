#!/usr/bin/env bash
function get_tag {
  echo `cd ./projects/$1 && node -p "require('./package.json').version"`
}

cat << EOF > Dockerrun.aws.json
{
  "AWSEBDockerrunVersion": 2,
  "volumes": [
    {
      "name": "docker-socket",
      "host": {
        "sourcePath": "/var/run/docker.sock"
      }
    }
  ],
  "containerDefinitions": [
    {
      "name": "reverse-proxy",
      "image": "traefik:1.7.6-alpine",
      "essential": true,
      "memory": 128,
      "portMappings": [
        {
          "hostPort": 80,
          "containerPort": 80
        }
      ],
      "mountPoints": [
        {
          "sourceVolume": "docker-socket",
          "containerPath": "/var/run/docker.sock",
          "readOnly": true
        }
      ],
      "command": ["--docker"],
      "links": [
        "cop-watch-portal",
        "cop-watch-api-gateway"
      ]
    },
    {
      "name": "cop-watch-portal",
      "image": "$DOCKER_USERNAME/cop-watch-portal:$(get_tag cop-watch-portal)",
      "essential": true,
      "memory": 128
    },
    {
      "name": "cop-watch-api-gateway",
      "image": "$DOCKER_USERNAME/cop-watch-api-gateway:$(get_tag cop-watch-api-gateway)",
      "essential": true,
      "memory": 128
    },
    {
      "name": "cop-watch-data-proxy",
      "image": "$DOCKER_USERNAME/cop-watch-data-proxy:$(get_tag cop-watch-data-proxy)",
      "essential": true,
      "memory": 128,
      "links": [
        "cop-watch-api-gateway"
      ]
    }
  ]
}
EOF

zip $BEANSTALK_ZIP_FILENAME Dockerrun.aws.json
