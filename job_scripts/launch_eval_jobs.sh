#!/bin/bash

# -------------------------------------------------------------------
# IMITATION LEARNING
# -------------------------------------------------------------------

# Original camera settings & MP3D segmentation

SEGMENTATION=mp3d
MODEL=original_camera_settings_and_${SEGMENTATION}_detector
CKPTS=(28)

EVAL_SETTINGS=(original_camera_settings)

for EVAL_SETTING in ${EVAL_SETTINGS[@]}; do
    for CKPT in ${CKPTS[@]}; do
        sbatch job_scripts/il/submit_eval_job.sh \
            $CONFIG_ROOT/il_ddp_objectnav_${EVAL_SETTING}_and_${SEGMENTATION}_detector.yaml \
            $TB_ROOT/il_model_eval/$MODEL/$EVAL_SETTING/ckpt$CKPT \
            $CKPT_ROOT/il_model/$MODEL/ckpt.$CKPT.pth
    done
done

EVAL_SETTINGS=(robot_camera_settings_with_noise robot_camera_settings_without_noise)

for EVAL_SETTING in ${EVAL_SETTINGS[@]}; do
    for CKPT in ${CKPTS[@]}; do
        sbatch job_scripts/il/submit_eval_job.sh \
            $CONFIG_ROOT/il_ddp_objectnav_${EVAL_SETTING}_and_${SEGMENTATION}_detector_with_obs_transforms.yaml \
            $TB_ROOT/il_model_eval/$MODEL/$EVAL_SETTING/ckpt$CKPT \
            $CKPT_ROOT/il_model/$MODEL/ckpt.$CKPT.pth
    done
done

# Original camera settings & COCO segmentation

SEGMENTATION=coco
MODEL=original_camera_settings_and_${SEGMENTATION}_detector
EVAL_SETTINGS=(robot_camera_settings_with_noise robot_camera_settings_without_noise)
CKPTS=(12 16 20)

for EVAL_SETTING in ${EVAL_SETTINGS[@]}; do
    for CKPT in ${CKPTS[@]}; do
        sbatch job_scripts/il/submit_eval_job.sh \
            $CONFIG_ROOT/il_ddp_objectnav_${EVAL_SETTING}_and_${SEGMENTATION}_detector_with_obs_transforms.yaml \
            $TB_ROOT/il_model_eval/$MODEL/$EVAL_SETTING/ckpt$CKPT \
            $CKPT_ROOT/il_model/$MODEL/ckpt.$CKPT.pth
    done
done

# Robot camera settings & COCO segmentation

SEGMENTATION=coco
MODEL=robot_camera_settings_and_${SEGMENTATION}_detector
EVAL_SETTINGS=(robot_camera_settings_with_noise robot_camera_settings_without_noise)
CKPTS=(12 16 20)

for EVAL_SETTING in ${EVAL_SETTINGS[@]}; do
    for CKPT in ${CKPTS[@]}; do
        sbatch job_scripts/il/submit_eval_job.sh \
            $CONFIG_ROOT/il_ddp_objectnav_${EVAL_SETTING}_and_${SEGMENTATION}_detector.yaml \
            $TB_ROOT/il_model_eval/$MODEL/$EVAL_SETTING/ckpt$CKPT \
            $CKPT_ROOT/il_model/$MODEL/ckpt.$CKPT.pth
    done
done

# -------------------------------------------------------------------
# REINFORCEMENT LEARNING FINE-TUNING
# -------------------------------------------------------------------

# Robot camera settings & COCO segmentation

SEGMENTATION=coco
MODEL=robot_camera_settings_and_${SEGMENTATION}_detector
EVAL_SETTINGS=(robot_camera_settings_with_noise robot_camera_settings_without_noise)
CKPTS=(17)

for EVAL_SETTING in ${EVAL_SETTINGS[@]}; do
    for CKPT in ${CKPTS[@]}; do
        sbatch job_scripts/il/submit_eval_job.sh \
            $CONFIG_ROOT/il_rl/ddppo_semseg_ft_objectnav_${EVAL_SETTING}_and_${SEGMENTATION}_detector.yaml \
            $TB_ROOT/rl_model_finetune_eval/$MODEL/$EVAL_SETTING/ckpt$CKPT \
            $CKPT_ROOT/rl_model_finetune/$MODEL/ckpt.$CKPT.pth
    done
done

# Original camera settings & MP3D segmentation

SEGMENTATION=mp3d
MODEL=original_camera_settings_and_${SEGMENTATION}_detector
CKPTS=(32)

EVAL_SETTINGS=(original_camera_settings)

for EVAL_SETTING in ${EVAL_SETTINGS[@]}; do
    for CKPT in ${CKPTS[@]}; do
        sbatch job_scripts/il/submit_eval_job.sh \
            $CONFIG_ROOT/il_rl/ddppo_semseg_ft_objectnav_${EVAL_SETTING}_and_${SEGMENTATION}_detector.yaml \
            $TB_ROOT/rl_model_finetune_eval/$MODEL/$EVAL_SETTING/ckpt$CKPT \
            $CKPT_ROOT/rl_model_finetune/$MODEL/ckpt.$CKPT.pth
    done
done

EVAL_SETTINGS=(robot_camera_settings_with_noise robot_camera_settings_without_noise)

for EVAL_SETTING in ${EVAL_SETTINGS[@]}; do
    for CKPT in ${CKPTS[@]}; do
        sbatch job_scripts/il/submit_eval_job.sh \
            $CONFIG_ROOT/il_rl/ddppo_semseg_ft_objectnav_${EVAL_SETTING}_and_${SEGMENTATION}_detector_with_obs_transforms.yaml \
            $TB_ROOT/rl_model_finetune_eval/$MODEL/$EVAL_SETTING/ckpt$CKPT \
            $CKPT_ROOT/rl_model_finetune/$MODEL/ckpt.$CKPT.pth
    done
done
