# An substitute model for training the FEM model
import tensorflow as tf
import numpy as np
from scipy.io import *
import gc
import warnings
import matplotlib.pyplot as plt
class dnn:
   

    # 初始化定义
    def __init__(self,nodes):
        self.nodes=nodes
        input_n=self.nodes[0]
        last=len(self.nodes)-1
        output_n=self.nodes[last]
        self.x=tf.placeholder('float32',shape=[None,input_n],name='input_x')
        self.y_=tf.placeholder('float32',shape=[None,output_n],name='input_y')
        self.y=self.x

        i=1
        while i<last:
            self.addLayer(self.nodes[i-1],self.nodes[i],str(i))
            i=i+1
        self.addLayer(self.nodes[last-1],self.nodes[last],str(i))
        tf.add_to_collection('output', self.y)

    # 产生权重
    def weight_variable(self,shape,name):  # shape形状的随机数
        initial = tf.truncated_normal(shape, stddev=0.1)
        return tf.Variable(initial,name=name,dtype='float32')

    # 产生偏置
    def bias_variable(self,shape,name):
        initial = tf.constant(0.1, shape=shape)
        return tf.Variable(initial,name=name)

    def addLayer(self,n1,n2,index): # 加层
        W=self.weight_variable([n1,n2],'w'+index)
        b=self.bias_variable([n2],'b'+index)
        # self.y=tf.nn.dropout(tf.nn.leaky_relu(tf.matmul(self.y,W)+ b),rate=0.7)
        self.y=tf.nn.leaky_relu(tf.matmul(self.y,W)+ b) # 通过激活函数leaky_Relu


        # 训练集
    def training(self):
        #mat_x=loadmat('r10wan_cs.mat')['r']
        #mat_y=loadmat('vv10wan26_cs.mat')['vv26']
        
        mat_x=loadmat('4ceng\\r.mat')['r']
        mat_y=loadmat('4ceng\\v27.mat')['v27']
        

        data_len=80000
        trainx=mat_x[0:data_len,:]
        trainy=mat_y[0:data_len,:]
        predictx=mat_x[data_len:data_len+20000,:]
        predicty=mat_y[data_len:data_len+20000,:]
        epoch_n=10000
        global_step = tf.Variable(0,trainable=False) # 全局下降步数
        initial_learningrate = 1e-5  # 初始学习率
        #初始的学习速率是0总的迭代次数是1000次，如果staircase = True，那就表明每decay_steps次计算学习速率变化，更新原始学习速率，如果是False，那就是每一步都更新学习速率。红色表示False，绿色表示True


        dy=tf.subtract(self.y_,self.y)  # 预测-真实
        self.errory=tf.reduce_mean(tf.abs(dy)) # tf.降维.取平均   残差绝对值和最小

        # 保存
        saver=tf.train.Saver() #
       # train_step = tf.train.AdamOptimizer(1e-5).minimize(self.errory) # 用Adam算法：计算每个参数的自适应学习率方法,效果最好

        learning_rate = tf.train.exponential_decay(initial_learningrate, global_step=global_step, decay_steps=1600, decay_rate=0.96,staircase=True)
        train_step = tf.train.AdamOptimizer(learning_rate).minimize(self.errory)  # 用Adam算法：计算每个参数的自适应学习率方法,效果最好
        # decayed_learning_rate = learning_rate * exp(-decay_rate * global_step)


        accuracy=self.errory # 目标loss函数最小化

        sess = tf.InteractiveSession()
        sess.run(tf.global_variables_initializer())
        #saver.restore(sess,'dnn0.003/model.ckpt')
        i=0
        batchsize=50  # 一部分一部分的样本去训练效果更优
        lasterror=float('inf')

  

        # 训练
        try:
            for epoch in range(epoch_n):
                
             i=0
             while i<data_len:
                train_step.run(feed_dict={self.x:trainx[i:i+batchsize], self.y_: trainy[i:i+batchsize]}) # 初始化好的x和y训练函数
                i=i+batchsize
             #for X,Y in zip(trainx,trainy):
             #   train_step.run(feed_dict={self.x:np.reshape(X,[1,64]), self.y_: np.reshape(Y,[1,1])})
             # prediction_value=train_step.run(prection,)
             train_error=accuracy.eval(feed_dict={self.x:trainx,self.y_: trainy})
             print('epoch:',epoch,' diff: ',train_error)
             predic_error=accuracy.eval(feed_dict={self.x:predictx,self.y_: predicty})
             print('epoch:',epoch,' predict_diff: ',predic_error)




             if lasterror>train_error:
                 lasterror=train_error
                 saver.save(sess,'dj6/model.ckpt')
                 print('save model')
             if train_error<0.001:
                 print('Done')
                 break
        except Exception as e:
            print('error:',e)

        # fig=plt.figure()
        # ax=fig.add_subplot(1,1,1)
        # ax.scatter(self.x,self.y) # 连续点画图
        # plt.show()
        # plt.scatter(self.x, self.y_)
        # plt.plot(self.x, self.y, 'r-', lw=5)
        # plt.show()



def test():
    a=dnn([64,128,256,256,256,256,256,1]) # 4层26号节点0.5、0.2变化
    a.training()
   
# 只在当前⽂件中调⽤该函数，其他导⼊的⽂件内不符合该条件，则不执⾏test函数调⽤
if __name__ == '__main__':        
    warnings.filterwarnings("ignore")
    test()

