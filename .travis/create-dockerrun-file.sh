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
      "image": "jwilder/nginx-proxy:alpine",
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
          "containerPath": "/tmp/docker.sock",
          "readOnly": true
        }
      ]
    },
    {
      "name": "cop-watch-portal",
      "image": "$DOCKER_USERNAME/cop-watch-portal:$(get_tag cop-watch-portal)",
      "essential": true,
      "memory": 128,
      "environment": [
        {
          "name": "VIRTUAL_HOST",
          "value": "localhost,cop-watch-production-environment.egbk2sq3vn.eu-west-1.elasticbeanstalk.com"
        },
        {
          "name": "VIRTUAL_PORT",
          "value": 8080
        }
      ],
      "links": [
        "reverse-proxy"
      ]
    }
  ]
}
EOF

zip $BEANSTALK_ZIP_FILENAME Dockerrun.aws.json
