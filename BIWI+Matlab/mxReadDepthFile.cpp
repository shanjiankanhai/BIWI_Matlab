#include <fstream>
#include <stdint.h>
#include "mex.h"
#include <sstream>
#include <string>
/**
 * Usage: [x,y,z] = mxReadDepthFile('frame_XXXXX_depth.bin',cam_intrinsic,zThresh);   三个参数，分别是深度数据文件、相机参数、
 * 函数调用是通过文件名直接调用
 * 
 */

using namespace std;
void mexFunction (int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[])    // nlhs是输出参数数量，plhs指的是指向输出参数的指针，nrhs是输入参数数量
{                                                                          // prhs[]是用来存储输入参数的数组
    /*-----------------------------------------------------------*/
    /*    检查输入参数，如果参数不足三个输出错误*/
    if (nrhs != 3 )
        mexErrMsgTxt("Incorrect number of input arguments!");
    
    /*   从prhs中读取压缩深度图像的名字*/
    char* fname = mxArrayToString(prhs[0]);                             //将mxArray转换为c、c++字符串，读取文件名
    
    /*          读取相机的固有参数*/              
	double* depth_intrinsic = mxGetPr(prhs[1]);	
    
    /*        打开深度图像.bin文件*/
 	FILE* pFile = fopen(fname, "rb");
	if(!pFile)
    {
		mexErrMsgTxt("Could not open file!");
		return;
	}
    
    /*                 读取深度图像的宽度和高度*/
  	int im_width = 0; int im_height = 0;              //定义高度和宽度
 	fread(&im_width,sizeof(int),1,pFile);             // sizeof定义每次读取元素个数，读取宽度数据并存储
  	fread(&im_height,sizeof(int),1,pFile);            //读取高度数据并储存，到此处已经读取了2个sizeof
 
    /*                   存储深度数据*/
 	int16_t* depth_img = new int16_t[im_width * im_height];   //定义一个数组存储深度数据

    /*                  读取二进制深度数据 */
 	int numempty;
 	int numfull;
 	int p = 0;
    while(p < im_width*im_height )
    {
  		 fread( &numempty,sizeof(int),1,pFile);    //读取sizeof（int）个的数据存储在numempty中，读取第3个sizeof
		for(int i = 0; i < numempty; i++)       //把depth_img数组从0-numempty的内容设置为0
			depth_img[ p + i ] = 0;

		fread( &numfull,sizeof(int), 1, pFile);   //读取第4个sizeof（int）个的数据
		fread( &depth_img[ p + numempty ], sizeof(int16_t), numfull, pFile) ;     //一次读取sizeof（int16_t)个内容，读取numfull次
		p += numempty+numfull;
	}

	fclose(pFile);
    
    /*-----------------------------------------------------------*/
    /*     */
    plhs[0] = mxCreateDoubleMatrix(im_height,im_width,mxREAL);
    plhs[1] = mxCreateDoubleMatrix(im_height,im_width,mxREAL);
    plhs[2] = mxCreateDoubleMatrix(im_height,im_width,mxREAL);     //实现内存的申请，创建矩阵对象
    double *X = mxGetPr(plhs[0]);                             //从指向mxArray类型数据的plhs[0]获得了指向double类型的指针
    double *Y = mxGetPr(plhs[1]);
    double *Z = mxGetPr(plhs[2]);
    
    int g_max_z = (int)prhs[2];                                //将第三个参数传入
    
	for(int y = 0; y < im_height; y++)
	{
        for(int x = 0; x < im_width; x++)
        {
            // 
            float d = depth_img[y*im_width+x];
			if ( d < g_max_z && d > 0 )
            {
                // 
				X[x*im_height+y] = d * (float(x) - depth_intrinsic[2])/depth_intrinsic[0];
				Y[x*im_height+y] = d * (float(y) - depth_intrinsic[5])/depth_intrinsic[4];
				Z[x*im_height+y] = d;
			}
			else
            {
				X[x*im_height+y] = 0.0;
				Y[x*im_height+y] = 0.0;
				Z[x*im_height+y] = 0.0;
			}
		}
	}
   
    delete [] depth_img;
    mxFree(fname);
    return;
}