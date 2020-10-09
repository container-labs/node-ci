FROM gcr.io/containerlabs/gcloud-ci:latest

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs build-essential

# need this to build after install
RUN npm -g install node-pre-gyp yarn

# build this to pull in the devDeps package
RUN yarn global add firebase-tools@8.11.2 --unsafe
RUN yarn global add @sentry/cli@1.58.0
#RUN yarn global add  @babel/cli@7.2.0 @babel/core@7.2.0

RUN mkdir -p /tools/bin

COPY ./cloud-sdk-deploy /tools/bin/cloud-sdk-deploy
COPY ./firebase-deploy /tools/bin/firebase-deploy

# add gcloud and firebase executables to the path
ENV PATH="/tools/bin/:${PATH}"

RUN npm --version
RUN yarn -v

CMD ["cloud-sdk-deploy"]
