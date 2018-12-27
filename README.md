# Cop Watch
Project for SOFT352. Users can visually explore police data from stop and search to crime outcomes.

Running a local environment:
- Setup the aws cli
- Set up the elastic beanstalk cli
- Run `eb init` and go through options
- Run `./.travis/create-dockerrun-file.sh` to create the Dockerrun.aws.json file
- Run `eb local run`
- Hey presto!

Potential features:
- Explore local areas for:
    - Stop and searches
    - Crime outcomes
    - Neighbourhood priorities
    - Policing team/senior officers
- View trends for:
    - Stop and searches
    - Crime outcomes
    - Crime
- Predict trends for:
    - Stop and searches
    - Crime outcomes
    - Crime
- Comment/discuss/rate:
    - Forces
    - Activities force conducts (stop and search, crime outcome)

Notes:
- Monorepo:
    - Individual services maintain their own version
    - Releases are tagged to maintain system version

Credit:
Some Travis monorepo code from here: https://github.com/sagikazarmark/travis-monorepo-demo
