# Get CUDA image
FROM nvidia/cuda:11.6.0-base-ubuntu18.04

ENV PATH /opt/conda/bin:$PATH

# From https://www.analyticsvidhya.com/blog/2020/08/docker-based-python-development-with-cuda-support-on-pycharm-and-or-visual-studio-code/#h2_3
RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion && \
    apt-get clean

# Install miniconda with the latest version
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

# Set up working directory
WORKDIR /

# Install requirements for the application
ADD requirements.txt .
RUN python -m pip install --no-cache-dir --user -r requirements.txt

# Copy other files on the app to Docker image
COPY . .

# Run the app
CMD ["python3", "run.py"]
