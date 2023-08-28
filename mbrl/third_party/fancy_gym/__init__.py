import fancy_gym
import gym
from gym import Env


class TruncatedWrapper(gym.Wrapper):
    """Adapts old gym interface to gymnasium.Env interface"""
    def reset(self, **kwargs):
        obs = self.env.reset(**kwargs)
        return obs, {}

    def step(self, action):
        obs, reward, terminated, info = self.env.step(action)
        return obs, reward, terminated, False, info


def make(env_id: str, seed: int) -> Env:
    env = fancy_gym.make(
        env_id=env_id,
        seed=seed,
    )
    return TruncatedWrapper(env=env)
