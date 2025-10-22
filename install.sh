mkdir miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-py310_24.5.0-0-Linux-x86_64.sh -O miniconda3/miniconda.sh
bash miniconda3/miniconda.sh -b -u -p miniconda3

# Initialize Conda
source miniconda3/bin/activate

conda create -n re-call python==3.10
conda activate re-call

pip3 install -e .
pip3 install flash-attn --no-build-isolation

cd scripts/serving
python sandbox.py --port {8000}