#!/bin/bash

#SBATCH --ntasks=152
#SBATCH --mem=501599mb
#SBATCH --time=1-23:59:00
#SBATCH --partition=accelerated
#SBATCH --job-name=ruben_episode_transformer
#SBATCH --gres=gpu:4

#SBATCH -D /home/hk-project-robolear/ht9329/mbrl-lib
#SBATCH -o /home/hk-project-robolear/ht9329/mbrl-lib/slurmlogs/out_%A_%a.log
#SBATCH -e /home/hk-project-robolear/ht9329/mbrl-lib/slurmlogs/err_%A_%a.log

sweep_id=rjacob/masters/xzmm5c2f
echo Running with sweep id $sweep_id
echo Available GPUs: $CUDA_VISIBLE_DEVICES

source .venv/bin/activate
cd mbrl/examples
(CUDA_VISIBLE_DEVICES=0 wandb agent $sweep_id) &
pid1=$!
(CUDA_VISIBLE_DEVICES=1 wandb agent $sweep_id) &
pid2=$!
(CUDA_VISIBLE_DEVICES=2 wandb agent $sweep_id) &
pid3=$!
(CUDA_VISIBLE_DEVICES=3 wandb agent $sweep_id) &
pid4=$!
wait $pid1 $pid2 $pid3 $pid4
