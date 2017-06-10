## Dockerfile to build DeepQ&A container image

FROM python:2.7.13

COPY requirements.txt /

## CaloGAN stuff
RUN  \
  pip install -r /requirements.txt

# TensorBoard
EXPOSE 6006

# Jupyter
# EXPOSE 8888

# "Borrow" `run_jupyter.sh` from Google TF team...
# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
# COPY ../run_jupyter.sh /

# Set up our notebook config.
# COPY ../jupyter_notebook_config.py /root/.jupyter/

# ADD *.ipynb /notebooks/
# WORKDIR /notebooks

WORKDIR /workspace

# start up notebook
# CMD ["/run_jupyter.sh", "--NotebookApp.token=''"]

# launch bash
CMD ["/bin/bash"]
