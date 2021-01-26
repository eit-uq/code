import os
from tensorflow.python import pywrap_tensorflow
from scipy.io import *
checkpoint_path = os.path.join("E:\PythonNihehuigui\dj6", "model.ckpt")
#checkpoint_path = os.path.join("E:\PythonNihehuigui\res_dnn", "model.ckpt")
reader = pywrap_tensorflow.NewCheckpointReader(checkpoint_path) #tf.train.NewCheckpointReader
var_to_shape_map = reader.get_variable_to_shape_map()
map_dict={}
for key in var_to_shape_map:
	#print("tensor_name: ", key)
	#print(reader.get_tensor(key))
        map_dict[key]=reader.get_tensor(key).tolist()
#print(map_dict)
        
savemat('dj6\map_dict.mat',map_dict)       
#savemat('res_dnn\map_dict.mat',map_dict)
