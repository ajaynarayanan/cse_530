#include <sstream>
#include <string>
#include <fstream>
#include <iostream>
#include <vector>

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

vector< vector<int> > transpose(vector< vector<int> > src) {
	// src is of size m*n
	// we assume at least there is one row
	int m = src.size(), n = src[0].size(), row, col;

	// initialise dest with 0s
	vector<vector<int>> dest(n, vector<int>(m, 0));

	// transpose each element column wise
	for(col=0; col<n; ++col)
	{
		for(row=0; row<m; ++row)
		{
			dest[col][row] = src[row][col];
		}
	}
	return dest;
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
	std::cout<<"test\n";
	string filename;
	if (argc < 3) {
		filename = "input_matrix.in";
	} else {
		filename = argv[2];
	}
	Result result = read (filename);
	std::cout<<"number of matrices read : "<<result.list_of_matrices.size()+1<<"\n";
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
		parsec_roi_begin();
		vector< vector<int> > dest = transpose(src);
		parsec_roi_end();
		printMatrix(dest);
	}
	else
	{
		int i, n = result.list_of_matrices.size();
		vector< vector<int> > src;
		// do it for a bunch of matrices
		parsec_roi_begin();
		for(i=0; i<n; ++i)
		{
			cout<<"matrix : "<<i<<"\n";
			vector< vector<int> > dest = transpose(result.list_of_matrices[i]);
			printMatrix(dest);
		}
		parsec_roi_end();
	}
	
	return 0;
}
