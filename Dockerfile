FROM ubuntu:14.04

##############
# Setup Area #
##############


# Update packages
RUN apt-get update --fix-missing -y 

# Install Python Setuptools
RUN apt-get install -y python-setuptools

# Install pip
RUN easy_install pip

# Install git
RUN apt-get install -y git

RUN apt-get update
RUN apt-get install -y libcurl3

# Install GitPython
RUN pip install GitPython==0.3.6 Django==1.6 django-tagging==0.3 httplib2 jinja2 docutils parameters hgapi pyyaml

# Cleaning up

# Including files.
COPY . /src
RUN cd /src/sumatra-integrate; python setup.py install
RUN cd /src; rm -rf sumatra-integrate/

# Setup Sumatra
# RUN git config --global user.email "scientist_email@domain.com"
# RUN git config --global user.name "scientist_name"
# RUN cd /src; git init
# RUN cd /src; git add --all
# RUN cd /src; git commit -m "init."
# RUN cd /src; smt init demo-sumatra
# RUN cd /src; smt configure --store="http://10.0.0.184:5100/api/v1/private/3a8d4cc793bd3e5b85c733b523584545991ea74ebe91ff51c7945e10bdc97e40"

# Expose Smtweb port
EXPOSE 5000

###################
# Researcher Area #
###################

# Install core dependencies
RUN echo "Y" | apt-get install python-numpy

# Install python dependencies
# Note: Simulation dependencies have to be put in the requirements.txt file.
# RUN cd /src; pip install -r requirements.txt

# Usage
# To Build: ./manage.sh --build --simulation ddsm-demo
# To Run without smtweb: ./manage.sh --run-core --simulation ddsm-demo
# To Run with smtweb./manage.sh --run-web --simulation ddsm-demo
# To force Stop: ./manage.sh --stop --simulation ddsm-demo