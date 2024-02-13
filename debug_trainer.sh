#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
while read var value
do
    export "$var"="$value"
done < $SCRIPT_DIR/config.conf

# python args
# arg1="Python"
# arg2=


CFG_FILE="SportPose/configs/mvp/shelf_config/mvp_shelf.py"
CFG_FILE="SportPose/configs/mvp/moyo_config/mvp_moyo_scaled.py"

GPUS_PER_NODE=1



cd $WORKDIR
source $CONDA_SOURCE
conda activate $CONDA_ENV
python -m debugpy --listen 0.0.0.0:$PORT --wait-for-client -m torch.distributed.launch \
        --nproc_per_node=${GPUS_PER_NODE} \
        --master_port 65530 \
        --use_env $WORKDIR/SportPose/tools/train_model.py \
        --cfg ${CFG_FILE} $arg1 $arg2
conda deactivate