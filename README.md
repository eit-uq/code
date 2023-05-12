# code
This code realizes the uncertainty quantization of high-dimensional parameters in EIT.
The results are executed in the following runtime environment:
Computer processor: Intel(R) Core(TM) i5-9300H CPU @ 2.40GHz;
Type of computer system: 64-bit operating system, based on X64 processor;
Computer RAM: 8.00 GB;
Software version: MATLAB 2019 and PYTHON 3.6.

The following is the original code file of DNN-UDR

DNN.py:An substitute model for training the FEM model;
UDR_sampling.m：Sampling function of dimensionality reduction method;
data_yuan.m：Construct the header model of the multidimensional parameters of the EIT;
get_model_variables.py，Obtain the variable information of the alternative model-DNN network, prepare for the invocation of this model by the dimension reduction method;
loadmodel.py：The DNN network is reloaded to test the generalization ability of the alternative model;
mainMCM.m：It is the main program of Monte Carlo method and a classical algorithm in the field of uncertainty quantification, and its results are used as experimental benchmarks.A sample set of alternative models was generated, where conductivity was used as input and voltage as output;
mainUDR.m：The main program of the dimensional reduction method;
mainforw.m：The main program for constructing the head model by finite element method;
qdianji.m：A subroutine for the construction of the head model, the experimental simulation of the EIT electrode setup procedure;
qxishuzhen.m：A subroutine for the construction of the head model, the solution of the Laplace equation;
r.mat：Input matrix of training set of DNN network.Random distribution of conductivity parameters obtained by finite element calculation;
v.mat：Label matrix of training set of DNN network.When the conductivity is subject to random uniform distribution, the electrode point voltage calculated by finite element is obtained when the conductivity is subject to random uniform distribution;
