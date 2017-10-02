FROM gcr.io/project-charlotte/google-sdk-ci:latest

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs build-essential

# overload this a little and add the firebase-tools package
RUN npm install -g firebase-tools --unsafe

RUN mkdir -p /tools/bin

COPY ./cloud-sdk-deploy /tools/bin/cloud-sdk-deploy
COPY ./firebase-deploy /tools/bin/firebase-deploy

# add gcloud and firebase executables to the path
ENV PATH="/tools/bin/:${PATH}"

CMD ["cloud-sdk-deploy"]
