/*
    This file is used to call the final alpha expansion for the problem to get
    photomontage.
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string>
#include <time.h>
#include <fstream>
#include <iostream>
#include "GCoptimization.h"

using namespace std;

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


        Data(string ufilename, string sfilename) {
            ifstream f(ufilename);
	        ifstream g(sfilename);

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
	        int temp;
	        g >> temp >> temp >> temp;

            for(int i = 0; i < num_labels_ * width_ * height_ * 3; i++) {
                g >> smooth_data_[i];
            }
        }

    private:
        int width_, height_, num_labels_;
        int *data_, *smooth_data_;

};

struct ForDataFn {
    int num_labels, height, width;
    int *data;
    int *smooth_data;
};

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
        energy_diff_2_R*energy_diff_2_R + energy_diff_2_G*energy_diff_2_G + energy_diff_2_B*energy_diff_2_B));
}

int main() {
    string fname = "../../temp_result/uninary_cost.txt";
    string gname = "../../temp_result/raw_smoothness_cost.txt";
    string output_file = "../../temp_result/temp_result.txt";

    Data data(fname, gname);
    //data.print_data();

    GCoptimizationGridGraph *gc = new GCoptimizationGridGraph(data.get_width(), data.get_height(), data.get_num_labels());
    ForDataFn data_fn;
    data_fn.num_labels = data.get_num_labels();
    data_fn.width = data.get_width();
    data_fn.height = data.get_height();
    data_fn.data = data.get_unary_cost();
    data_fn.smooth_data = data.get_smooth_cost();

    gc->setDataCost(&dataFn, &data_fn);
    gc->setSmoothCost(&smoothFn, &data_fn);
    gc-> expansion(50);

    int result_size = data.get_width() * data.get_height();
    
    ofstream fout(output_file);
    
    for (int i = 0; i < result_size; i++) {
        fout << gc->whatLabel(i) << " ";
    }
   
    return 0;
}
