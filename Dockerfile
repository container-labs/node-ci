FROM containerlabs/google-sdk-ci:latest

RUN echo new node 1210
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs build-essential

# ugh, so much ugh
# https://github.com/npm/npm/issues/17781
# installing locally because
# https://github.com/npm/npm/issues/15558
#RUN npm install npm@6.4
#RUN rm -rf /usr/lib/node_modules
#RUN mv node_modules /usr/lib/

# need this to build after install
RUN npm -g install node-pre-gyp yarn

# 2020-02-06
RUN echo new tools 2020-02-06
# build this to pull in the devDeps package
RUN yarn global add firebase-tools@8.11.2 --unsafe
RUN yarn global add @sentry/cli@1.58.0
#RUN yarn global add  @babel/cli@7.2.0 @babel/core@7.2.0

RUN mkdir -p /tools/bin

COPY ./cache /tools/bin/cache
COPY ./cloud-sdk-deploy /tools/bin/cloud-sdk-deploy
COPY ./firebase-deploy /tools/bin/firebase-deploy

# add gcloud and firebase executables to the path
ENV PATH="/tools/bin/:${PATH}"

RUN npm --version
RUN yarn -v

CMD ["cloud-sdk-deploy"]
