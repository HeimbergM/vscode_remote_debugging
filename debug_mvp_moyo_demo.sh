#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
while read var value
do
    export "$var"="$value"
done < $SCRIPT_DIR/config.conf

# python args
# arg1="Python"
arg2="--output_dir /work/dlclarge2/heimberm-masterprojekt/SportPose/output/estimation/mvp_moyo_demo \
    --model_dir /work/dlclarge2/heimberm-masterprojekt/SportPose/weight/mvp/xrmocap_mvp_shelf-22d1b5ed_20220831.pth \
    --estimator_config /work/dlclarge2/heimberm-masterprojekt/SportPose/configs/modules/core/estimation/end2end_moyo_estimator.py \
    --image_and_camera_param /work/dlclarge2/heimberm-masterprojekt/SportPose/xrmocap_data/MOYO/xrmocap_meta_trainset/image_and_camera_param.txt \
    --start_frame 300 \
    --end_frame 350   --enable_log_fi"

cd $WORKDIR
source $CONDA_SOURCE
conda activate $CONDA_ENV
python -m debugpy --listen 0.0.0.0:$PORT --wait-for-client $WORKDIR/SportPose/tools/mview_mperson_end2end_estimator_moyo.py $arg1 $arg2
conda deactivate