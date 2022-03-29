import os
import torch

print(f'cuda.is_available: {torch.cuda.is_available()}')

print(f'cuda.current_device: {torch.cuda.current_device()}')

#torch.cuda.device(0)

print(f'cuda.device_count: {torch.cuda.device_count()}')

print(f'cuda.get_device_name: {torch.cuda.get_device_name(0)}')

# To properly run this line of code
# CUDA_VISIBLE_DEVICES=0,1,2 python <script>
print(os.environ["CUDA_VISIBLE_DEVICES"])
