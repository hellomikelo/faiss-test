# pull miniconda image
FROM continuumio/miniconda3

# copy local files into container
COPY requirements.txt /tmp/
COPY pair /tmp/pair
# COPY output /tmp/output
COPY data /tmp/data

# install python 3.6 (needed to work with tensor flow) and faiss
RUN conda install python=3.6
RUN conda install faiss-cpu=1.5.1 -c pytorch -y

ENV PORT 8080

# change directory
WORKDIR /tmp

# install dependencies
RUN apt-get update && apt-get install -y vim
RUN pip install -r requirements.txt

# change directory
WORKDIR /tmp/pair

# run commands
CMD ["streamlit", "run", "./app.py"]
