#include <sstream>
#include <string>
#include <fstream>
#include <iostream>
#include <vector>
#include <algorithm>
#include <random>

using namespace std;

void parsec_roi_begin() 
{

}

void parsec_roi_end() 
{

}


struct Result {
	vector<vector< vector<int> >> list_of_matrices;
};

Result read(string filename) {
	vector< vector<int> > A;
	Result result;
	string line;
	ifstream infile;
	infile.open (filename.c_str());

	int i = 0;
	while (getline(infile, line)) {

		// read the next matrix
		if(line.empty())
		{
			result.list_of_matrices.push_back(A);
			i = 0;
			A.clear();
		}
		else
		{
			istringstream iss(line);
			A.resize(A.size() + 1);
			int a, j = 0;
			while (iss >> a) {
				A[i].push_back(a);
				j++;
			}
			i++;
		}
	}
	result.list_of_matrices.push_back(A);
	
	infile.close();
	return result;
}

vector<int> gather(vector< vector<int> > src, vector<int> indices) {
	// src is of size m*n, assume row major implmentation
	// we assume at least there is one row
	int m = src.size(), n = src[0].size(), i, row, col;
	int ind_sz = indices.size();

	// initialise dest with 0s
	vector<int> dest(ind_sz);

	// iterate over the indices and get the value 
	for(i=0; i<ind_sz; ++i)
	{
		row = (int)(indices[i] / n );
		col = indices[i] % n ;
		dest[i] = src[row][col];
	}
	return dest;
}

vector<int> generateRandomIndices(int m, int n, int num_of_elems)
{
	int i;
	// naive way to generate random indices
    vector<int> population = vector<int>(m*n, 0);
	// code adapted from : https://stackoverflow.com/questions/28287138/c-randomly-sample-k-numbers-from-range-0n-1-n-k-without-replacement
	for(i=0;i<m*n;++i)
		population[i] = i;
    vector<int> sample;
    std::sample(population.begin(), population.end(), 
                std::back_inserter(sample),
                num_of_elems,
                std::mt19937{std::random_device{}()});

	return sample;
}

void printMatrix(vector< vector<int> > matrix) {
	vector< vector<int> >::iterator it;
	vector<int>::iterator inner;
	for (it=matrix.begin(); it != matrix.end(); it++) {
		for (inner = it->begin(); inner != it->end(); inner++) {
			cout << *inner;
			if(inner+1 != it->end()) {
				cout << "\t";
			}
		}
		cout << endl;
	}
}

int main (int argc, char* argv[]) {
	std::cout<<"gather\n";
	string filename;
	if (argc < 3) {
		filename = "input_matrix.in";
	} else {
		filename = argv[2];
	}
	Result result = read (filename);
	
	std::cout<<"number of matrices read : "<<result.list_of_matrices.size()<<"\n";
	for (int k =0; k<result.list_of_matrices.size();++k)
	{
		cout<<"matrix : "<<k<<"\n";
		vector<vector<int>> matrix = result.list_of_matrices[k];
		printMatrix(matrix);
	}

	std::cout<<"starting the process\n";

	if(result.list_of_matrices.size() == 1)
	{	
		vector< vector<int> > src = result.list_of_matrices[0];
		int m = src.size(), n = src[0].size();
		// generate random indices 
		vector<int> randomIndices = generateRandomIndices(m, n, rand()%(m*n));
		parsec_roi_begin();
		vector<int> dest = gather(src, randomIndices);
		parsec_roi_end();
		cout<<"Done with gathering\n";
		printMatrix(vector<vector<int>>(1, dest));
	}
	else
	{
		int i, x = result.list_of_matrices.size();
		vector< vector<int> > src;
		int m = src.size(), n = src[0].size();
		// generate random indices 
		vector<int> randomIndices = generateRandomIndices(m, n, rand()%(m*n));
		// do it for a bunch of matrices
		parsec_roi_begin();
		for(i=0; i<x; ++i)
		{
			// cout<<"matrix : "<<i<<"\n";
			vector<int> dest = gather(result.list_of_matrices[i], randomIndices);
			// printMatrix(vector<vector<int>>(1, dest));
		}
		parsec_roi_end();
	}
	
	return 0;
}
