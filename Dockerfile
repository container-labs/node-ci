FROM containerlabs/google-sdk-ci:latest

RUN echo new node 1210
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs build-essential

# ugh, so much ugh
# https://github.com/npm/npm/issues/17781
# installing locally because
# https://github.com/npm/npm/issues/15558
RUN npm install npm@6.4
RUN rm -rf /usr/lib/node_modules
RUN mv node_modules /usr/lib/

# need this to build after install
RUN npm -g install node-pre-gyp yarn

# 2018-10-28
RUN echo new tools 1210
# overload this a little and add the firebase-tools package
RUN yarn global add firebase-tools --unsafe
RUN yarn global add  @babel/cli@7.2.0 @babel/core@7.2.0

RUN mkdir -p /tools/bin

COPY ./cache /tools/bin/cache
COPY ./cloud-sdk-deploy /tools/bin/cloud-sdk-deploy
COPY ./firebase-deploy /tools/bin/firebase-deploy

# add gcloud and firebase executables to the path
ENV PATH="/tools/bin/:${PATH}"

RUN npm --version
RUN yarn -v

CMD ["cloud-sdk-deploy"]
