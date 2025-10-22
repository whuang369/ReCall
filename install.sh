mkdir miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-py310_24.5.0-0-Linux-x86_64.sh -O miniconda3/miniconda.sh
bash miniconda3/miniconda.sh -b -u -p miniconda3

source miniconda3/bin/activate

conda create -n re-call python==3.10
conda activate re-call

pip3 install -e .
pip3 install flash-attn --no-build-isolation

cd scripts/serving
python sandbox.py --port 8000

bash train.sh \
    --train_batch_size 1 \
    --ppo_mini_batch_size 4 \
    --use_re_call True \
    --prompt_template_name re_call_template_sys \
    --actor_model_path Qwen/Qwen2.5-1.5B-Instruct \
    --search_url http://127.0.0.1:8000 \
    --sandbox_url http://127.0.0.1:8000 \
    --project_name ReCall-small-gpu \
    --experiment_name recall_qwen1p5b_ins \
    --nnodes 1 \
    --n_gpus_per_node 1 \
    --save_freq 5 \
    --test_freq 5 \
    --total_epochs 2 \
    --wandb_api_key d0dbec0b8f79cdb57ef36ae46bb16a336954b2ca \
    --save_path ../../outputs/recall_qwen1p5b_ins \
    --train_files "['../../data/agentrl__ReCall-data/train.parquet']" \
    --test_files "['../../data/agentrl__ReCall-data/validation.parquet']"

