FROM python:3.6
MAINTAINER Esben Haabendal, esben@haabendal.dk

# Bind mount your configuration file to /brscan.yaml or whatever $CONFIG_FILE
# is set to

# This is where the scan output will be written to
VOLUME /output

# This must be mapped to ${ADVERTISE_IP}:54925
EXPOSE 54925/udp

# Install required Debian packages
RUN apt-get update -q \
 && apt-get install -q -y sane sane-utils poppler-utils libusb-0.1-4 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install required python modules
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

# Install Brother scanner driver
# (http://support.brother.com/g/s/id/linux/en/download_scn.html)
COPY brscan4-0.4.4-1.amd64.deb /tmp/
RUN dpkg --install /tmp/brscan4-*.deb

# Fixup symbolic links
RUN mkdir /usr/lib/sane \
 && for f in /usr/lib64/sane/libsane-brother*;do ln -s $f /usr/lib/sane/;done

# Install brscan (run "setup.py build sdist" before docker build)
COPY dist/brscan-0.0.1.tar.gz /tmp/
RUN pip install --no-binary :all: /tmp/brscan-*.tar.gz

# Add run script and set it as default command
ADD run.sh /
CMD /run.sh
