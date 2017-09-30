FROM gcr.io/project-charlotte/google-sdk-ci:latest

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs build-essential

CMD ["node", "--version"]
