/*
    This file is used to call the alpha expansion for getting final photomontage.
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string>
#include <time.h>
#include <fstream>
#include <iostream>

#include <sstream>
#include "GCoptimization.h"

using namespace std;
//shift_map_array
class Data {
    public:
        int get_width() {
            return width_;
        }

        int get_height() {
            return height_;
        }

        int get_num_labels() {
            return num_labels_;
        }

        int *get_unary_cost() {
            return data_;
        }

        int *get_smooth_cost() {
            return smooth_data_;
        }
  
        int *get_shift_map(){
          return shift_map_;
        }

        void print_data() {
            cout << width_ << " " << height_ << " " << num_labels_ << endl;

            for(int i = 0; i < num_labels_ * width_ * height_; i++) {
                cout << data_[i] << " ";
            }
            cout << endl;

            for(int i = 0; i < num_labels_ * width_ * height_ * 3; i++) {
                cout << smooth_data_[i] << " ";
            }
        }

        Data(){
          ;
        }
        void init(string ufilename, string sfilename,string smapfilename) {
            ifstream f(ufilename);
            ifstream g(sfilename);
            ifstream h(smapfilename);
            f >> width_ >> height_ >> num_labels_;
            // assuming data is aligned in a single array row wise for each label.
            // i.e l1d11 l1d12 .. l1d21 l1d22 .. ... l2d11 l2d12 ..
            data_ = new int[num_labels_ * width_ * height_];
            for(int i = 0; i < num_labels_ * width_ * height_; i++) {
                f >> data_[i];
            }
            // assuming all data for R for one image comes first followed by G and B for
            // each label.
            smooth_data_ = new int[num_labels_ * width_ * height_ * 3];
            shift_map_ = new int[num_labels_*width_*height_];
           int temp;
            g >> temp >> temp >> temp;
            for(int i = 0; i < num_labels_ * width_ * height_ * 3; i++) {
                g >> smooth_data_[i];
            }
          for(int i=0;i<width_*height_;i++)
          {
            h>>shift_map_[i];
          }
        }

    private:
        int width_, height_, num_labels_;

        int *data_, *smooth_data_,*shift_map_;


};

struct ForDataFn {
    int num_labels, height, width;
    int *data;
    int *smooth_data;
    int *shift_map;

};

int dataFn(int pixel, int label, void *data) {
    ForDataFn *my_data = (ForDataFn *) data;

    int height = my_data->height;
    int width = my_data->width;
    int x = pixel / width;
    int y = pixel % width;

    // going to label and then going to the pixel in that label data.
    int dest = label * width * height + pixel;
    return my_data->data[dest];
}




int smoothFn(int pixel1, int pixel2, int label1, int label2, void *data) {

    if (label1 == label2) {
        return 0;
    }

    ForDataFn *my_data = (ForDataFn *) data;

    int imgW = my_data->width;
    int imgH = my_data->height;
    int *mdata = my_data->smooth_data;

    // locij implies location of pixel i in image with label j;
    int loc11 = label1*imgW*imgH*3 + pixel1;
    int loc12 = label2*imgW*imgH*3 + pixel1;
    int loc21 = label1*imgW*imgH*3 + pixel2;
    int loc22 = label2*imgW*imgH*3 + pixel2;

    float energy_diff_1_R = (float) (mdata[loc11] - mdata[loc12]);
    float energy_diff_1_G = (float) (mdata[loc11 + imgW*imgH] - mdata[loc12 + imgW*imgH]);
    float energy_diff_1_B = (float) (mdata[loc11 + 2*imgW*imgH] - mdata[loc12 + 2*imgW*imgH]);

    float energy_diff_2_R = (float) (mdata[loc22] - mdata[loc21]);
    float energy_diff_2_G = (float) (mdata[loc22 + imgW*imgH] - mdata[loc21 + imgW*imgH]);
    float energy_diff_2_B = (float) (mdata[loc22 + 2*imgW*imgH] - mdata[loc21 + 2*imgW*imgH]);

    return (int) (sqrt(energy_diff_1_R*energy_diff_1_R + energy_diff_1_G*energy_diff_1_G + energy_diff_1_B*energy_diff_1_B) + sqrt(
        energy_diff_2_R*energy_diff_2_R + energy_diff_2_G*energy_diff_2_G + energy_diff_2_B*energy_diff_2_B))+10;
}

int dataFinalFn(int pixel, int label, void *data) {
    ForDataFn *my_data = (ForDataFn *) data + label;
    int height = my_data->height;
    int width = my_data->width;
    int x = pixel / width;
    int y = pixel % width;
    // for pixel (x,y) neighbors are (x-1, y), (x+1, y), (x, y-1), (x, y+1)
    int neighbors[4] = { width*(x-1) + y, width*(x+1) + y, width*x + y - 1, width*x + y + 1};

    int un_cost = dataFn(pixel, my_data->shift_map[pixel], (void *) my_data);
    int sm_cost = 0;
    for(int i = 0; i < 4; i++) {
        if(neighbors[i] < 0 or neighbors[i] >= height*width) {
            continue;
        }
        sm_cost += smoothFn(
            pixel, neighbors[i], my_data->shift_map[pixel], my_data->shift_map[neighbors[i]], (void *)my_data);

    }
    return un_cost + sm_cost;
}


int smoothFinalFn(int pixel1, int pixel2, int label1, int label2, void *data) {

    if (label1 == label2) {
        return 0;
    }

    // transformation label must start from 0
    ForDataFn *my_data = (ForDataFn *) data;

    ForDataFn *data_label1,*data_label2;

    data_label1 = my_data + label1;
    data_label2 = my_data + label2;

    // my_data would point to data of first transformation and width height should be same for all transformation data 
    int imgW = my_data->width;
    int imgH = my_data->height;

    int *shiftmap_label1 = data_label1->shift_map;
    int *shiftmap_label2 = data_label2->shift_map;

    int translation_label1=shiftmap_label1[pixel1];
    int translation_label2=shiftmap_label2[pixel2];

    // locij implies location of pixel i in image with label j;
    int loc11 = translation_label1*imgW*imgH*3 + pixel1;
    int loc12 = translation_label2*imgW*imgH*3 + pixel1;
    int loc21 = translation_label1*imgW*imgH*3 + pixel2;
    int loc22 = translation_label2*imgW*imgH*3 + pixel2;

    int *mdata_label1=data_label1->smooth_data;
    int *mdata_label2=data_label2->smooth_data;

    float energy_diff_1_R = (float) (mdata_label1[loc11] - mdata_label2[loc12]);
    float energy_diff_1_G = (float) (mdata_label1[loc11 + imgW*imgH] - mdata_label2[loc12 + imgW*imgH]);
    float energy_diff_1_B = (float) (mdata_label1[loc11 + 2*imgW*imgH] - mdata_label2[loc12 + 2*imgW*imgH]);

    float energy_diff_2_R = (float) (mdata_label2[loc22] - mdata_label1[loc21]);
    float energy_diff_2_G = (float) (mdata_label2[loc22 + imgW*imgH] - mdata_label1[loc21 + imgW*imgH]);
    float energy_diff_2_B = (float) (mdata_label2[loc22 + 2*imgW*imgH] - mdata_label1[loc21 + 2*imgW*imgH]);

    return (int) (sqrt(energy_diff_1_R*energy_diff_1_R + energy_diff_1_G*energy_diff_1_G + energy_diff_1_B*energy_diff_1_B) + sqrt(
        energy_diff_2_R*energy_diff_2_R + energy_diff_2_G*energy_diff_2_G + energy_diff_2_B*energy_diff_2_B))+10;
}
int main() {

    int num_transformation_label,j;
    num_transformation_label=20;
    stringstream Fname;
    stringstream Gname;
    stringstream Shift_map;
    string output_file_transformation = "../../temp_result/final_output_transformation.txt";
    string output_file_translation = "../../temp_result/final_output_translation.txt";

    Data data[20];
    ForDataFn data_fn[20];
    for(j=0;j<num_transformation_label;j++)
    {
      Fname.str("");
      Gname.str("");
      Shift_map.str("");
      Fname<<"../../temp_result/uninary_cost_"<<j<<".txt";
      Gname<<"../../temp_result/raw_smoothness_cost_"<<j<<".txt";
      Shift_map<<"../../temp_result/shift_map_"<<j<<".txt";
      string fname=Fname.str();
      string gname=Gname.str();
      string shift_mapname=Shift_map.str();
      //Data1[j](fname,gname,shift_map);
      data[j].init(fname,gname,shift_mapname);
      data_fn[j].num_labels = data[j].get_num_labels();
      data_fn[j].width = data[j].get_width();
      data_fn[j].height = data[j].get_height();
      data_fn[j].data = data[j].get_unary_cost();
      data_fn[j].smooth_data = data[j].get_smooth_cost();
      data_fn[j].shift_map = data[j].get_shift_map();
  }
    GCoptimizationGridGraph *gc = new GCoptimizationGridGraph(data[0].get_width(), data[0].get_height(),num_transformation_label);

    gc->setDataCost(&dataFinalFn, data_fn);
    gc->setSmoothCost(&smoothFinalFn, data_fn);
    gc-> expansion(0);

    // cout << "testing" <<endl;

    int result_size = data[0].get_width() * data[0].get_height();

    ofstream ftfout(output_file_transformation);
    ofstream ftlout(output_file_translation);

    for (int i = 0; i < result_size; i++) {
        ftfout << gc->whatLabel(i) << " ";
    }


    for (int i = 0; i < result_size; i++) {     
        ftlout << data_fn[gc->whatLabel(i)].shift_map[i] << " "; 
    
    }

    return 0;
}
