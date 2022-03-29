# Get cUDA-PyTorch image from NVIDIA
FROM nvidia/pytorch:22.03-py

RUN apt-get update

# Set up working directory
WORKDIR /

# Install requirements for the application
ADD requirements.txt .
RUN pip3 install --no-cache-dir --user -r requirements.txt

# Copy other files on the app to Docker image
COPY . .

# Run the app
CMD ["python3", "run.py"]
