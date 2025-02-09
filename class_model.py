import random
import numpy as np
import torch

from habitat_baselines.common.baseline_registry import baseline_registry
from pirlnav.config import get_config


class Pirlnav:
    def __init__(self):

        self.run_type = "eval"
        self.seed = 37338945
        self.path = "configs/experiments/rl_ft_objectnav.yaml"
        self.opt = ['TENSORBOARD_DIR', 'tb/objectnav_il_rl_ft/ovrl_resnet50/seed_1/', 'EVAL_CKPT_PATH_DIR', 'model/objectnav_rl_ft_hd.ckpt', 'NUM_UPDATES', '20000', 'NUM_ENVIRONMENTS', '1', 'RL.DDPPO.pretrained', 'False', 'TASK_CONFIG.DATASET.SPLIT', 'val', 'TASK_CONFIG.DATASET.DATA_PATH', "'data/datasets/objectnav/hm3d/v1//{split}/{split}.json.gz'"]

        # Load configuration
        config = get_config(self.path, self.opt)

        config.defrost()
        config.RUN_TYPE = self.run_type
        config.TASK_CONFIG.SEED = self.seed
        config.freeze()
        random.seed(config.TASK_CONFIG.SEED)
        np.random.seed(config.TASK_CONFIG.SEED)
        torch.manual_seed(config.TASK_CONFIG.SEED)

        if config.FORCE_TORCH_SINGLE_THREADED and torch.cuda.is_available():
            torch.set_num_threads(1)

        trainer_init = baseline_registry.get_trainer(config.TRAINER_NAME)
        assert trainer_init is not None, f"{config.TRAINER_NAME} is not supported"

        self.trainer = trainer_init(config)

    def evaluation(self, observation):
        # print(observation['image'].shape, observation['obj_goal'], observation['position'])

        action = self.trainer.eval(observation)
        return action

