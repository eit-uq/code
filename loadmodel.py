# The DNN network is reloaded to test the generalization ability of the alternative model
import tensorflow as tf
import numpy as np
# from scipy.io import *
import scipy.io as io
import matplotlib.pyplot as plt
with tf.Session() as sess:
 new_saver = tf.train.import_meta_graph('50bianhua/model.ckpt.meta') # 导入图
 new_saver.restore(sess, '50bianhua/model.ckpt')
 y = tf.get_collection('output')[0]# 获取tensor
 graph = tf.get_default_graph()
 input_x=graph.get_operation_by_name('input_x').outputs[0]
 #mat_x=io.loadmat('r.mat')['r']
 #mat_y=io.loadmat('v6.mat')['vv6']
 mat_x=io.loadmat('50bianhua/r10wan_cs.mat')['r']
 mat_y=io.loadmat('50bianhua/vv10wan26cs.mat')['vv26']
     #print(mat_y)
     #print(np.transpose(mat_y))
     #print(round(mat_y))
     #print(len(np.transpose(mat_y)))
    

 start=0
    # for start in range(len(np.transpose(mat_y))):
 predictx=mat_x[start:start+100000,:]
 predicty=mat_y[start:start+100000,:]
 out=sess.run(y, feed_dict={input_x : predictx })# 得到了模型各个地方的tensor后获取该地方的参数或者输出的值只需要通过sess.run();参数可以直接run，中间的特征或者预测值需要通过feed_dict={}传递输入的值

         #start+=100
         #print(predictx)
         #print(predicty)
     
     #reader = tf.train.NewCheckpointReader('dnn/model.ckpt')
     #all_variables = reader.get_variable_to_shape_map()
     #w1 = reader.get_tensor("w:0")
     #print(type(w1))
     #print(w1.shape)
     #print(w1[0])  
     

 plt.plot(predicty,color='blue')
 plt.plot(out,color='red')
         
        #plt.ion()       #可以让程序show了之后不暂停，继续往下走，从而形成动态
 plt.show()
 plt.xlabel('Sample number')
 plt.ylabel('Voltage(mV)')       
    


    # 查看参数变量
    #var=tf.trainable_variables()
    #value=sess.run(var)
    #for v in value:
      #  print(v)
      


 io.savemat('dj6/vv6cs.mat',{'u':out,'x':predictx})
# print("weights:", out)
#print("b:0", sess.run(graph.get_tensor_by_name('b:0')))  
