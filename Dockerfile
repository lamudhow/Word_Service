# Install our own perl as we're pretty lightweight so just take a basic Ubuntu
FROM debian:buster-slim

# Add Plack from apt to get the plackup script installed, and add dictionary
RUN apt-get update \
  && apt-get install -y \
     build-essential \
     dictionaries-common \
     wbritish \
     curl \
     perl \
     libplack-perl \
     cpanminus \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists

COPY cpanfile cpanfile
RUN cpanm -n --installdeps .

# Drop down to user
RUN adduser --disabled-password --disabled-login \
  --gecos "dancer2 user" --home /home/dancer2 dancer2
USER dancer2
WORKDIR /home/dancer2

# COPY . is evil (https://domm.plix.at/talks/writing_a_good_dockerfile_for_perl_app.html)
COPY .dancer .dancer
COPY bin bin
COPY lib lib
COPY config.yml config.yml
COPY environments environments
COPY public public
COPY views views

# Debugging
# COPY t t
# CMD [ "/usr/bin/tail", "-f", "/dev/null" ]

CMD [ "/usr/bin/plackup", "-p", "80", "/home/dancer2/bin/app.psgi" ]
