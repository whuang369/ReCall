conda create -n re-call python==3.10
conda activate re-call

pip3 install -e .
pip3 install flash-attn --no-build-isolation

cd scripts/serving
python sandbox.py --port {8000}