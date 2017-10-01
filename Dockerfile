FROM gcr.io/project-charlotte/google-sdk-ci:latest

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs build-essential

# overload this a little and add the firebase-tools package
RUN npm install -g firebase-tools

COPY ./sdk-deploy.sh .

CMD ["./sdk-deploy.sh"]
