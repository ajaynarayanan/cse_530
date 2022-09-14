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

vector<vector<int>> scatter(vector< vector<int> > src, vector<int> indices, vector<int> values) {
	// src is of size m*n, assume row major implmentation
	// we assume at least there is one row
	int n = src[0].size(), i, row, col;
	int ind_sz = indices.size();

	// initialise dest with 0s
	vector<int> dest(ind_sz);

	// iterate over the indices and write the value to the matrix 
	for(i=0; i<ind_sz; ++i)
	{
		row = (int)(indices[i] / n );
		col = indices[i] % n ;
		src[row][col] = values[i];
	}
	return src;
}

vector<int> generateRandomIndices(int m, int n, int num_of_elems)
{
	int i;
	// naive way to generate random indices
	// code adapted from : https://stackoverflow.com/questions/28287138/c-randomly-sample-k-numbers-from-range-0n-1-n-k-without-replacement
    vector<int> population = vector<int>(m*n, 0);
	for(i=0;i<m*n;++i)
		population[i] = i;
    vector<int> sample;
    std::sample(population.begin(), population.end(), 
                std::back_inserter(sample),
                num_of_elems,
                std::mt19937{std::random_device{}()});

	return sample;
}

vector<int> generateRandomValues(int num_of_elems, int max_range = 2000)
{
	int i;
	// naive way to generate random indices
    vector<int> values(num_of_elems, 0);
	for(i=0; i<num_of_elems; ++i)
	{
		values[i] = rand() % max_range;
	}

	return values;
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
	// for (int k =0; k<result.list_of_matrices.size();++k)
	// {
	// 	cout<<"matrix : "<<k<<"\n";
	// 	vector<vector<int>> matrix = result.list_of_matrices[k];
	// 	printMatrix(matrix);
	// }

	std::cout<<"starting the process\n";

	if(result.list_of_matrices.size() == 1)
	{	
		vector< vector<int> > src = result.list_of_matrices[0];
		int m = src.size(), n = src[0].size();
		// generate random value between [0, (m*n)/2]
		int num_of_elems = rand()%(m*n) / 2;
		// generate random indices 
		vector<int> randomIndices = generateRandomIndices(m, n, num_of_elems);
		// generate random values 
		vector<int> randomValues = generateRandomValues(num_of_elems);
		parsec_roi_begin();
		vector<vector<int>> dest = scatter(src, randomIndices, randomValues);
		parsec_roi_end();
		cout<<"Done with scattering\n";
		// printMatrix(dest);
	}
	else
	{
		int i, x = result.list_of_matrices.size();
		vector< vector<int> > src;
		int m = src.size(), n = src[0].size();
		// generate random value between [0, (m*n)/2]
		int num_of_elems = rand()%(m*n) / 2;
		// generate random indices 
		vector<int> randomIndices = generateRandomIndices(m, n, num_of_elems);
		// generate random values 
		vector<int> randomValues = generateRandomValues(num_of_elems);
		// do it for a bunch of matrices
		parsec_roi_begin();
		for(i=0; i<x; ++i)
		{
			// cout<<"matrix : "<<i<<"\n";
			vector<vector<int>> dest = scatter(result.list_of_matrices[i], randomIndices, randomValues);
			// printMatrix(dest);
		}
		parsec_roi_end();
	}
	
	return 0;
}
