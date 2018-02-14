#!/bin/bash

function jupyter_install(){
    test_jup=`which jupyter`
    if test "${test_jup#*/jupyter}" == "$test_jup"; then
        echo "Jupyter isn't installed. Installing..."
        pip3 install --upgrade pip
        pip3 install jupyter
        jupyter notebook --generate-config -y
        echo "c.NotebookApp.tornado_settings = {" > $HOME/.jupyter/jupyter_notebook_config.py
        echo "    'headers': {" >> $HOME/.jupyter/jupyter_notebook_config.py
        echo "        'Content-Security-Policy': \"frame-ancestors http://*:9999 'self' \"" >> $HOME/.jupyter/jupyter_notebook_config.py
        echo "    }" >> $HOME/.jupyter/jupyter_notebook_config.py
        echo "}" >> $HOME/.jupyter/jupyter_notebook_config.py
        echo "c.NotebookApp.ip = '*'" >> $HOME/.jupyter/jupyter_notebook_config.py
        echo "c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py
    else
        echo "Jupyter is already installed. Skipping..."
    fi
}

jupyter_install