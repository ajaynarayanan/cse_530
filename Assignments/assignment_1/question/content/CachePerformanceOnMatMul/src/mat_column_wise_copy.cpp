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
		istringstream iss(line);
		A.resize(A.size() + 1);
		int a, j = 0;
		while (iss >> a) {
			A[i].push_back(a);
			j++;
		}
		i++;
	}

	infile.close();
	return result;
}

vector< vector<int> > columnWiseCopy(vector< vector<int> > src) {
	// src is of size m*n
	// we assume at least there is one row
	int m = src.size(), n = src[0].size(), row, col;

	// initialise dest with 0s
	vector<vector<int>> dest(m, vector<int>(n, 0));

	// copy each element column wise
	for(col=0; col<n; ++col)
	{
		for(row=0; row<m; ++row)
		{
			dest[row][col] = src[row][col];
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
	string filename;
	if (argc < 3) {
		filename = "2000.in";
	} else {
		filename = argv[2];
	}
	Result result = read (filename);
	for (auto matrix : result.list_of_matrices)
		printMatrix(matrix);

	if(result.list_of_matrices.size() == 1)
	{	
		vector< vector<int> > src = result.list_of_matrices[0];
		parsec_roi_begin();
		vector< vector<int> > dest = columnWiseCopy(src);
		parsec_roi_end();
	}
	else
	{
		int i, n = result.list_of_matrices.size();
		vector< vector<int> > src;
		// do it for a bunch of matrices
		parsec_roi_begin();
		for(i=0; i<n; ++i)
		{
			vector< vector<int> > dest = columnWiseCopy(result.list_of_matrices[i]);
		}
		parsec_roi_end();
	}

	return 0;
}
