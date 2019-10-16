FROM node:10.16.3-jessie

# Install dependence packages
RUN apt-get update \
    && apt-get install \
       gconf-service \
       libappindicator1 \
       libasound2 \
       libatk1.0-0 \
       libc6 \
       libcairo2 \
       libcups2 \
       libdbus-1-3 \
       libexpat1 \
       libfontconfig1 \
       libgcc1 \
       libgconf-2-4 \
       libgdk-pixbuf2.0-0 \
       libglib2.0-0 \
       libgtk-3-0 \
       libnspr4 \
       libnss3 \
       libpango-1.0-0 \
       libpangocairo-1.0-0 \
       libstdc++6 \
       libx11-6 \
       libx11-xcb1 \
       libxcb1 \
       libxcomposite1 \
       libxcursor1 \
       libxdamage1 \
       libxext6 \
       libxfixes3 \
       libxi6 \
       libxrandr2 \
       libxrender1 \
       libxss1 \
       libxtst6 \
       lsb-release \
       ca-certificates \
       fonts-liberation \
       python-pip \
       vim \
       xdg-utils \
       wget -y \
# Install NVM
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash \
    #&& . /root/.bashrc
    #&& nvm install 10.16.3
# Install yarn and Update npm
    && npm install -g yarn \
    && npm i npm@latest -g \
# Install aliyuncli
    && pip install -U pip \
    && pip install aliyuncli \
    && apt-get clean all \
    && rm -rf /tmp/*

# Copy osstuil config
COPY ossutilconfig /root/.ossutilconfig
# Copy ossutil binary files
COPY bin /usr/bin
# Copy fusion deploy key
COPY ssh /root/.ssh
