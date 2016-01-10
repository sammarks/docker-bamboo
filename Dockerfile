FROM nkatsaros/atlassian-bamboo:5.9

# Install PHP and Friends
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y --force-yes curl wget php5-cli php5-mysql php5-curl php5-mcrypt php5-sqlite php5-gd python-pip python-dev

# Install AWS
RUN pip install aws

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHPUnit
RUN wget https://phar.phpunit.de/phpunit.phar -O /usr/local/bin/phpunit
RUN chmod +x /usr/local/bin/phpunit

# Install NPM + Gulp
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y --force-yes nodejs npm
RUN npm install -g gulp
RUN npm install -g bower
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Create build directories.
RUN mkdir /home/atlassian
RUN chown -R atlassian:atlassian /home/atlassian

# Setup SSH config.
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
