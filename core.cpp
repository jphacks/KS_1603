#include <opencv2/opencv.hpp>

#define LOOP_MAX 100
#define EPS 2.2204e-04
#define NUM_NEIGHBOR 4

using namespace cv;

// --------------------------------
// 最適化部分
// RGB 3チャンネルに対してそれぞれ最適化
// --------------------------------

int quasi_poisson_solver(Mat &img_src, Mat &img_dst, Mat &img_mask, int channel, int offset[]) {
	
	// 近傍画素アクセス用
	int naddr[NUM_NEIGHBOR][2] = { { -1,0 },{ 0,-1 },{ 0,1 },{ 1,0 } };
	
	Mat img_new = ( cv::Mat_<double>(img_dst.rows, img_dst.cols) );

	// ベースの1チェンネルのコピーを作成
	for (int i = 0; i<img_dst.rows; i++) {
		for (int j = 0; j<img_dst.cols; j++) {
			img_new.at<double>(i, j) = (double)img_dst.at<Vec3b>(i, j)[channel];
		}
	}

	// LOOP_MAX になるまでは続行
	// 早く終われば抜ける
	for (int loop = 0; loop<LOOP_MAX; loop++) {
		bool ok = true;

		// マスクの全画素に注目
		for (int i = 0; i<img_mask.rows; i++) {
			for (int j = 0; j<img_mask.cols; j++) {

				// マスクの注目画素が黒でない場合 
				if ( (int)img_mask.at<Vec3b>(i, j)[0] > 0 ) {
					float sum_f = 0.0;
					float sum_vpq = 0.0;
					int count_neighbors = 0;
					for (int neighbor = 0; neighbor < NUM_NEIGHBOR; neighbor++) {
						if ( i + offset[0] + naddr[neighbor][0] >= 0 &&
							 j + offset[1] + naddr[neighbor][1] >= 0 &&
							 i + offset[0] + naddr[neighbor][0] < img_dst.rows &&
							 j + offset[1] + naddr[neighbor][1] < img_dst.cols ) {

							// 近隣画素の合計値
							sum_f += img_new.at<double>(i + offset[0] + naddr[neighbor][0], j + offset[1] + naddr[neighbor][1]);
							
							// 合成画像の注目画素と，近隣画素との差分の剛毅
							sum_vpq += (float)img_src.at<Vec3b>(i, j)[channel] -
								       (float)img_src.at<Vec3b>(i + naddr[neighbor][0], j + naddr[neighbor][1])[channel];

							count_neighbors++;
						}
					}
					// それぞれを足して平均値を算出
					float fp = (sum_f + sum_vpq) / (float)count_neighbors;

					// もとの注目画素との差分を絶対値で算出
					float error = fabs(fp - img_new.at<double>(i + offset[0], j + offset[1]));

					// 一定以下なら終了
					if ( ok &&error > (float)(EPS*(1.0f + fabs(fp))) ) {
						ok = false;
					}

					// 注目画素の値を更新
					img_new.at<double>(i + offset[0], j + offset[1]) = fp;
				}
			}
		}
		if ( ok ) {
			break;
		}
	}

	// ベースの1チェンネルを書き込み
	for (int i = 0; i<img_dst.rows; i++) {
		for (int j = 0; j<img_dst.cols; j++) {
			if (img_new.at<double>(i, j)>255) {
				img_new.at<double>(i, j) = 255.0;
			}
			else if (img_new.at<double>(i, j)<0) {
				img_new.at<double>(i, j) = 0.0;
			}
			img_dst.at<Vec3b>(i, j)[channel] = (uchar)img_new.at<double>(i, j);
		}
	}
	return 1;
}

int main() {
	// 合成画像
	cv::Mat source = imread("cat.png");
	// ベース画像
	cv::Mat destination = imread("girl.png");
	// マスク
	cv::Mat mask = imread("mask.png");

	// -----------------------------

	// オフセットの値を変えると注目画素の範囲が変わる
	int offset[2] = { 0,0 };
	for (int i = 0; i<3; i++) {
		quasi_poisson_solver(source, destination, mask, i, offset);
	}

	imshow("destination", destination);
	cv::waitKey(0);


	return 0;
}
