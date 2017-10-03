FROM gcr.io/project-charlotte/google-sdk-ci:latest

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs build-essential

# ugh, so much ugh
# https://github.com/npm/npm/issues/17781
# installing locally because
# https://github.com/npm/npm/issues/15558
RUN npm install npm@4
RUN rm -rf /usr/lib/node_modules
RUN mv node_modules /usr/lib/

# overload this a little and add the firebase-tools package
RUN npm install -g firebase-tools --unsafe

RUN mkdir -p /tools/bin

COPY ./cloud-sdk-deploy /tools/bin/cloud-sdk-deploy
COPY ./firebase-deploy /tools/bin/firebase-deploy

# add gcloud and firebase executables to the path
ENV PATH="/tools/bin/:${PATH}"

RUN npm --version

CMD ["cloud-sdk-deploy"]
